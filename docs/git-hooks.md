## Git Hooks

Add the following to `.git/hooks/precommit`

```bash
#!/bin/sh
flutter format --set-exit-if-changed lib test
flutter analyze lib test
```
