# exchange_app

A Flutter currency conversion app.

## Screenshots

<div style="display:Flex">
    <img src="https://github.com/user-attachments/assets/1962dbb7-7530-4255-9bb8-210348b904b1" width="35%">
    <img src="https://github.com/user-attachments/assets/aa2d0dd2-8aa4-4116-99c6-2a175f9c27ce" width="35%">
</div>

## Build Model

```
fvm dart run build_runner build --delete-conflicting-outputs
```

## Generate Localization

```
fvm flutter gen-l10n
```

## Run Project

```
fvm flutter pub get
fvm flutter run --dart-define=CURRENCY_API_KEY=your_api_key
```

## Test

Analyze and run unit/widget tests:

```
fvm dart analyze
fvm flutter test test
```

Run offline integration tests with fake API responses:

```
# Android emulator
fvm flutter test integration_test/app_test.dart -d emulator-5554 --dart-define=CURRENCY_API_KEY=

# iOS simulator. Replace the id with the simulator id from `fvm flutter devices`.
fvm flutter test integration_test/app_test.dart -d <ios-simulator-device-id> --dart-define=CURRENCY_API_KEY=
```
