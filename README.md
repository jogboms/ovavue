<div align="center">
  <h1>Ovavue</h1>
  <strong>A tidy budget overview planner.</strong>
  <br />
  <sub>Built with ❤︎ by <a href="https://twitter.com/jogboms">jogboms</a></sub>
  <br /><br />

[![Format, Analyze and Test](https://github.com/jogboms/ovavue/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/jogboms/ovavue/actions/workflows/main.yml) [![codecov](https://codecov.io/gh/jogboms/ovavue/branch/master/graph/badge.svg)](https://codecov.io/gh/jogboms/ovavue)

<a href='https://apps.apple.com/app/ovavue/id6449617480'><img alt='Get it from the App Store' src='./screenshots/app_store.png' height='36px'/></a>

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

### Install, L10n, Riverpod & Drift code generation

```bash
fvm flutter pub get 
fvm flutter pub run build_runner build
```

## Running

There are three (3) available environments:

- `mock`: Demo mode with non-persistent data
- `dev`: Development mode connected to [pkg:drift](https://pub.dev/packages/drift) in-memory instance
- `prod`: Production mode connected to [pkg:drift](https://pub.dev/packages/drift) production instance

To run in `mock` mode,

```bash
fvm flutter run --flavor mock --dart-define=env.mode=mock
```

## UI Shots

<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="./screenshots/1.png" width="200" />
      </td>
      <td style="text-align: center">
        <img src="./screenshots/2.png" width="200" />
      </td>
      <td style="text-align: center">
        <img src="./screenshots/3.png" width="200" />
      </td>
      <td style="text-align: center">
        <img src="./screenshots/4.png" width="200" />
      </td>
    </tr>
    <tr>
      <td style="text-align: center">
        <img src="./screenshots/5.png" width="200" />
      </td>
      <td style="text-align: center">
        <img src="./screenshots/6.png" width="200" />
      </td>
    </tr>
  </table>
</div>

## License

MIT License
