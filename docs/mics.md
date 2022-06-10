# Misc

## Build Contract Interfaces from ABI

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Linux Flutter Installation

```bash
# Stable
git clone https://github.com/flutter/flutter.git -b stable
echo 'PATH="$PATH:`pwd`/flutter/bin"' >> ~/.profile


 # Development
 git clone https://github.com/flutter/flutter.git
 echo 'PATH="$PATH:`pwd`/flutter/bin"' >> ~/.profile
```

## Git Hooks

`.git/hooks/precommit`

```bash
#!/bin/sh
flutter format --set-exit-if-changed lib test
flutter analyze lib test
```
