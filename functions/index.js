const { onCall, HttpsError } = require('firebase-functions/v2/https');
const admin = require('firebase-admin');

admin.initializeApp();

const REGION = 'us-central1';
const db = admin.firestore();
const bucket = admin.storage().bucket();
const deletionJobs = db.collection('_accountDeletionJobs');

async function markRetryPending(jobRef, failures) {
  await jobRef.set(
    {
      status: 'retry_pending',
      failures,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    },
    { merge: true },
  );
}

exports.deleteAccount = onCall(
  {
    region: REGION,
    enforceAppCheck: false,
    memory: '256MiB',
    timeoutSeconds: 120,
    maxInstances: 10,
  },
  async (request) => {
    const uid = request.auth && request.auth.uid;
    if (!uid) {
      throw new HttpsError('unauthenticated', 'Authentication is required.');
    }

    if (request.data && request.data.uid && request.data.uid !== uid) {
      throw new HttpsError(
        'permission-denied',
        'You can only delete your own account.',
      );
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const jobRef = deletionJobs.doc(uid);
    const userRef = db.collection('Users').doc(uid);

    const existingJob = await jobRef.get();
    const existingData = existingJob.exists ? existingJob.data() : {};

    await jobRef.set(
      {
        uid,
        status: 'in_progress',
        attempts: admin.firestore.FieldValue.increment(1),
        createdAt: existingData.createdAt || now,
        updatedAt: now,
      },
      { merge: true },
    );

    const storageFailures = [];

    try {
      await bucket.deleteFiles({
        prefix: `Users/${uid}/profile/`,
        force: true,
      });
    } catch (error) {
      storageFailures.push({
        step: 'delete-profile-prefix',
        message: error.message,
      });
    }

    if (storageFailures.length > 0) {
      await markRetryPending(jobRef, storageFailures);
      console.error('Account deletion storage cleanup failed', {
        uid,
        storageFailures,
      });
      throw new HttpsError(
        'internal',
        'Account deletion is incomplete. Please retry.',
        { retryable: true },
      );
    }

    try {
      await db.recursiveDelete(userRef);
    } catch (error) {
      const failures = [{ step: 'delete-firestore', message: error.message }];
      await markRetryPending(jobRef, failures);
      console.error('Account deletion Firestore cleanup failed', {
        uid,
        failures,
      });
      throw new HttpsError(
        'internal',
        'Account deletion is incomplete. Please retry.',
        { retryable: true },
      );
    }

    try {
      await admin.auth().deleteUser(uid);
    } catch (error) {
      if (error.code !== 'auth/user-not-found') {
        const failures = [{ step: 'delete-auth', message: error.message }];
        await markRetryPending(jobRef, failures);
        console.error('Account deletion auth cleanup failed', {
          uid,
          failures,
        });
        throw new HttpsError(
          'internal',
          'Your data was removed but sign-in deletion failed. Please retry.',
          { retryable: true },
        );
      }
    }

    try {
      await jobRef.delete();
    } catch (error) {
      console.warn('Account deletion job cleanup failed', {
        uid,
        message: error.message,
      });
    }

    return { success: true };
  },
);
