# Clean Ease

Clean Ease is a Flutter home-services app demo. It combines a service catalog, cart and
checkout flow, user profiles, addresses, and Firebase authentication in a GetX-based
application.

The catalog, prices, addresses, orders, and reviews are demo data stored in the app. This
repository does not include a commerce backend or payment processing.

## Features

- Onboarding with a persisted first-run flag.
- Email/password sign-up, sign-in, email verification, password reset, and Google Sign-In.
- User profile editing, image upload, address screens, and account deletion.
- Home, store, category, product detail, wishlist, cart, and checkout screens.
- Static demo payment methods and billing summary.
- Responsive layouts for compact phone widths and a web build target.

## Tech stack

- Flutter 3.24 / Dart 3.5
- GetX for state management, routing, and dependency injection
- Firebase Auth, Cloud Firestore, and Firebase Storage
- Google Sign-In
- GetStorage for local preferences
- Material 3 theming with Poppins fonts and Iconsax icons from `iconsax_flutter`

## Getting started

1. Install a Flutter SDK that satisfies the constraints in `pubspec.yaml`.
2. Fetch dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase (see below).
4. Run the app:

   ```bash
   flutter run
   ```

## Firebase configuration

The project expects Firebase to be configured before it starts:

- `lib/firebase_options.dart` is used by `main.dart`.
- Android uses `android/app/google-services.json`.
- Android app id: `com.example.clean_ease`.
- iOS bundle id: `com.example.freshApp`.
- The iOS target does **not** currently include `GoogleService-Info.plist` or a Google
  Sign-In URL scheme. Add both from your Firebase project before testing iOS Google
  Sign-In.

If you are setting up your own Firebase project, run `flutterfire configure` and replace
the generated files. Do not commit production credentials or signing material.

The HTTP helper and API constants are placeholders:

- `AppHttpHelper` points at `https://your-api.com`.
- `APIConstants.appSecretApiKey` is empty.

No backend integration is implemented behind these placeholders.

## Firebase security rules and tests

`firestore.rules` and `storage.rules` are tracked in the repository:

- Firestore `Users/{uid}` records are readable, writable, and deletable only by the
  authenticated owner. Profile fields are type/length validated, and `Email` and
  `Username` are immutable after creation.
- Profile images use `Users/{uid}/profile/{filename}`. Writes require the authenticated
  owner, a 5 MB size limit, and an allowed image MIME type. The legacy shared
  `Users/Images/Profile/` path is not writable.
- All other Firestore and Storage paths are denied by default.

Run the rules tests against the Firebase Emulator Suite:

```bash
cd test/firebase
npm install
npx firebase-tools@15.35.0 emulators:exec \
  --project demo-cleanease --only firestore,storage \
  --config ../../firebase.json "npm test"
```

The account deletion Cloud Function in `functions/` is prepared for review but is not
deployed and is not wired into the client yet. Do not deploy rules or functions without
reviewing the deployment steps and taking a backup where appropriate.

## Testing

```bash
flutter analyze
flutter test
```

The test suite covers validators, formatters, compact-screen layout widgets, the store
tab count, and onboarding layout.

## Web build

```bash
flutter build web --release
```

The output is written to `build/web`. The project uses `iconsax_flutter`, which supports
Flutter icon tree shaking, so the previous `--no-tree-shake-icons` workaround is no longer
needed. The Iconsax font is reduced from 670,228 bytes to 12,028 bytes in the release
build.

## Platform verification status

- Web release build was verified with the standard icon tree shaker.
- `flutter analyze` and `flutter test` are clean.
- Android and iOS builds were not verified in this environment because Android SDK/Java
  and Xcode are unavailable.
- Firebase authentication and Google Sign-In require a configured Firebase project and a
  device or simulator; end-to-end auth flows were not executed here.

## Project structure

```text
lib/
  common/        Shared widgets, styles, and layouts
  data/          Firebase repositories and authentication logic
  features/      Authentication, personalization, and shop screens
  utils/         Constants, validators, formatters, helpers, and themes
  app.dart       Root app widget and theme setup
  main.dart      Firebase and local-storage bootstrap
test/            Unit and widget tests
```

## Notes and limitations

- Product, order, address, and review content is static demo data.
- Checkout does not contact a payment provider.
- The repository still contains a tracked Firebase client configuration from the original
  project. Treat it as public client configuration, not as a server secret.
- Generated platform folders may need regeneration if you change bundle identifiers.
- Some files in the working tree show line-ending-only changes from Windows development;
  use `git diff --ignore-all-space` when reviewing.
