# Setup Firebase

- Install firebase cli https://firebase.google.com/docs/cli?authuser=1&hl=en#install-cli-mac-linux

- dart pub global activate flutterfire_cli
- flutterfire configure --project=mysarafu

## Auth Emulator


Run the following command to start the emulator:

```bash
firebase emulators:start
```

Also required that following [line](https://github.com/grassrootseconomics/mySarafu/blob/2c552fda9f751dbd7a4ae2587b74299fc1b9f96b/lib/bootstrap.dart#L58
) in bootstrap is uncommented
```dart
await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
```
