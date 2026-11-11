import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { after, before, beforeEach, test } from 'node:test';
import { fileURLToPath } from 'node:url';

import { initializeTestEnvironment } from '@firebase/rules-unit-testing';
import { doc, getDoc, setDoc, updateDoc } from 'firebase/firestore';
import { getBytes, ref, uploadBytes } from 'firebase/storage';

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '../..');
const projectId = 'demo-cleanease';

function parseHost(value) {
  const [host, port] = value.split(':');
  return { host, port: Number(port) };
}

const firestoreEmulator = parseHost(
  process.env.FIRESTORE_EMULATOR_HOST || '127.0.0.1:8080',
);
const storageEmulator = parseHost(
  process.env.FIREBASE_STORAGE_EMULATOR_HOST || '127.0.0.1:9199',
);

const pngBytes = new Uint8Array([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]);

const profileFor = (uid, overrides = {}) => ({
  FirstName: 'Alice',
  LastName: 'Example',
  Username: `cleanease_${uid}`,
  Email: `${uid}@example.com`,
  PhoneNumber: '',
  ProfilePicture: '',
  ...overrides,
});

let testEnv;

async function seedProfile(uid, overrides = {}) {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await setDoc(doc(db, 'Users', uid), profileFor(uid, overrides));
  });
}

function isPermissionDenied(error) {
  const text = `${error?.code ?? ''} ${error?.message ?? error}`;
  return /permission-denied|PERMISSION_DENIED|unauthorized|Missing or insufficient permissions/i.test(
    text,
  );
}

async function expectDenied(action) {
  await assert.rejects(action, (error) => isPermissionDenied(error));
}

before(async () => {
  testEnv = await initializeTestEnvironment({
    projectId,
    firestore: {
      rules: readFileSync(resolve(projectRoot, 'firestore.rules'), 'utf8'),
      ...firestoreEmulator,
    },
    storage: {
      rules: readFileSync(resolve(projectRoot, 'storage.rules'), 'utf8'),
      ...storageEmulator,
    },
  });
});

after(async () => {
  await testEnv?.cleanup();
});

beforeEach(async () => {
  await testEnv.clearFirestore();
  await testEnv.clearStorage();
});

test('1. unauthenticated users cannot read private profiles', async () => {
  await seedProfile('alice');
  const db = testEnv.unauthenticatedContext().firestore();

  await expectDenied(() => getDoc(doc(db, 'Users', 'alice')));
});

test('2. User A can read their own profile', async () => {
  await seedProfile('alice');
  const db = testEnv.authenticatedContext('alice').firestore();

  const snapshot = await getDoc(doc(db, 'Users', 'alice'));

  assert.equal(snapshot.exists(), true);
  assert.equal(snapshot.data().FirstName, 'Alice');
});

test('3. User A cannot read User B profile', async () => {
  await seedProfile('alice');
  await seedProfile('bob');
  const db = testEnv.authenticatedContext('alice').firestore();

  await expectDenied(() => getDoc(doc(db, 'Users', 'bob')));
});

test('4. User A cannot modify User B profile', async () => {
  await seedProfile('alice');
  await seedProfile('bob');
  const db = testEnv.authenticatedContext('alice').firestore();

  await expectDenied(() =>
    updateDoc(doc(db, 'Users', 'bob'), { FirstName: 'Compromised' }),
  );
});

test('5. unauthenticated Storage uploads are rejected', async () => {
  const storage = testEnv.unauthenticatedContext().storage();
  const objectRef = ref(storage, 'Users/alice/profile/avatar.png');

  await expectDenied(() =>
    uploadBytes(objectRef, pngBytes, { contentType: 'image/png' }),
  );
});

test('6. invalid MIME types are rejected', async () => {
  const storage = testEnv.authenticatedContext('alice').storage();
  const objectRef = ref(storage, 'Users/alice/profile/avatar.png');

  await expectDenied(() =>
    uploadBytes(objectRef, pngBytes, { contentType: 'text/plain' }),
  );
});

test('7. oversized uploads are rejected', async () => {
  const storage = testEnv.authenticatedContext('alice').storage();
  const objectRef = ref(storage, 'Users/alice/profile/avatar.png');
  const oversized = new Uint8Array(5 * 1024 * 1024 + 1);

  await expectDenied(() =>
    uploadBytes(objectRef, oversized, { contentType: 'image/png' }),
  );
});

test('8. valid owner uploads are accepted', async () => {
  const storage = testEnv.authenticatedContext('alice').storage();
  const objectRef = ref(storage, 'Users/alice/profile/avatar.png');

  const snapshot = await uploadBytes(objectRef, pngBytes, {
    contentType: 'image/png',
  });
  const storedBytes = await getBytes(objectRef);

  assert.equal(snapshot.metadata.contentType, 'image/png');
  assert.equal(
    storedBytes.byteLength ?? storedBytes.length,
    pngBytes.length,
  );
});

test('9. User A cannot write to User B Storage path', async () => {
  const storage = testEnv.authenticatedContext('alice').storage();
  const objectRef = ref(storage, 'Users/bob/profile/avatar.png');

  await expectDenied(() =>
    uploadBytes(objectRef, pngBytes, { contentType: 'image/png' }),
  );
});

test('10. User A cannot read User B profile image', async () => {
  const bobStorage = testEnv.authenticatedContext('bob').storage();
  await uploadBytes(ref(bobStorage, 'Users/bob/profile/avatar.png'), pngBytes, {
    contentType: 'image/png',
  });

  const aliceStorage = testEnv.authenticatedContext('alice').storage();
  await expectDenied(() =>
    getBytes(ref(aliceStorage, 'Users/bob/profile/avatar.png')),
  );
});

test('11. User A can update mutable own fields', async () => {
  await seedProfile('alice');
  const db = testEnv.authenticatedContext('alice').firestore();

  await updateDoc(doc(db, 'Users', 'alice'), { FirstName: 'Alicia' });
  const snapshot = await getDoc(doc(db, 'Users', 'alice'));

  assert.equal(snapshot.data().FirstName, 'Alicia');
});

test('12. User cannot change immutable Email or Username', async () => {
  await seedProfile('alice');
  const db = testEnv.authenticatedContext('alice').firestore();

  await expectDenied(() =>
    updateDoc(doc(db, 'Users', 'alice'), { Email: 'other@example.com' }),
  );
  await expectDenied(() =>
    updateDoc(doc(db, 'Users', 'alice'), { Username: 'changed' }),
  );
});

test('13. User cannot add unknown profile fields', async () => {
  await seedProfile('alice');
  const db = testEnv.authenticatedContext('alice').firestore();

  await expectDenied(() =>
    updateDoc(doc(db, 'Users', 'alice'), { IsAdmin: true }),
  );
});

test('14. User cannot create a profile for another user', async () => {
  const db = testEnv.authenticatedContext('alice').firestore();

  await expectDenied(() =>
    setDoc(doc(db, 'Users', 'bob'), profileFor('bob')),
  );
});

test('15. legacy shared Storage path is not writable', async () => {
  const storage = testEnv.authenticatedContext('alice').storage();
  const objectRef = ref(storage, 'Users/Images/Profile/avatar.png');

  await expectDenied(() =>
    uploadBytes(objectRef, pngBytes, { contentType: 'image/png' }),
  );
});

test('16. User A can create their own valid profile', async () => {
  const db = testEnv.authenticatedContext('alice').firestore();

  await setDoc(doc(db, 'Users', 'alice'), profileFor('alice'));
  const snapshot = await getDoc(doc(db, 'Users', 'alice'));

  assert.equal(snapshot.exists(), true);
  assert.equal(snapshot.data().Username, 'cleanease_alice');
});

test('17. User A can update the full profile with unchanged identity fields', async () => {
  await seedProfile('alice');
  const db = testEnv.authenticatedContext('alice').firestore();

  await updateDoc(
    doc(db, 'Users', 'alice'),
    profileFor('alice', {
      FirstName: 'Alicia',
      LastName: 'Example',
      ProfilePicture: 'https://example.com/profile.png',
    }),
  );
  const snapshot = await getDoc(doc(db, 'Users', 'alice'));

  assert.equal(snapshot.data().FirstName, 'Alicia');
  assert.equal(
    snapshot.data().ProfilePicture,
    'https://example.com/profile.png',
  );
});

test('18. invalid profile field types are rejected', async () => {
  const db = testEnv.authenticatedContext('alice').firestore();

  await expectDenied(() =>
    setDoc(doc(db, 'Users', 'alice'), {
      ...profileFor('alice'),
      FirstName: 123,
    }),
  );
});
