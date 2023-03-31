<div align="center">
  <h1>Ovavue</h1>
  <strong>A tidy budget overview planner.</strong>
  <br />
  <sub>Built with ❤︎ by <a href="https://twitter.com/jogboms">jogboms</a></sub>
  <br /><br />

[![Format, Analyze and Test](https://github.com/jogboms/ovavue/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/jogboms/ovavue/actions/workflows/main.yml) [![codecov](https://codecov.io/gh/jogboms/ovavue/branch/master/graph/badge.svg)](https://codecov.io/gh/jogboms/ovavue)
</div>

---

## Getting Started

After cloning,

### FVM setup

Install `fvm` if not already installed.

```bash
dart pub global activate fvm
```

Install local `flutter` version.

```bash
fvm install
```

### Install, L10n & Riverpod code generation

```bash
fvm flutter pub get 
fvm flutter gen-l10n
fvm flutter pub run build_runner build
```

## Running

There are three (3) available environments:
- `mock`: Demo mode with non-persistent data
- `dev`: Development mode connected to firebase dev instance
- `prod`: Production mode connected to firebase production instance

To run in `mock` mode,

```bash
fvm flutter run --flavor mock --dart-define=env.mode=mock
```

## License

MIT License
