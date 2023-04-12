# Locale Plus

LocalePlus allows easy access to native device locale data in Flutter apps. Includes language, country code, time zone, and number formatting preferences.

## Table of Content

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Author](#author)
- [Contributors](#contributors)
- [LICENSE](#license)

## Overview

LocalePlus is a Flutter package that allows developers to easily retrieve data from the native device locale settings. With LocalePlus, developers can access information such as the device's language, country code, and time zone, as well as the device's number formatting preferences such as grouping and decimal separator. This makes it easy to build internationalized apps that provide a personalized experience for each user. Whether you're building a financial app that needs to display numbers in the user's local format or a social media app that needs to display timestamps in the user's time zone, LocalePlus has you covered. With a simple and intuitive API, LocalePlus is the perfect tool for any Flutter developer looking to add localization to their app.

## Requirements

- Dart sdk: ">=2.16.2 <3.0.0"
- Flutter: ">=2.5.0"
- Android: minSdkVersion 16
- iOS 9.0+

## Installation

with Flutter:

```
flutter pub add locale_plus
```

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```
dependencies:
  locale_plus: ^1.1.0
```

## Usage

## Patch the locales with the users' group and decimal seperators

This function patches all locales in flutter, so that you can use the decimal seperator and group seperator from `numberFormatSymbols` after the patch is complete.
The patchNumberSeperators function patches the locales on android and ios.
It is safe to call on MacOS, Windows, Linux and web.

```Dart
import 'package:locale_plus/locale_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PatchAllLocales.patchNumberSeperators();
  runApp(const MyApp());
}
```

### Get Decimal & Grouping Separator

```Dart
final decimalSeparator = await LocalePlus().getDecimalSeparator();
final groupingSeparator = await LocalePlus().getGroupingSeparator();
```

### Get Language & Region Code

```Dart
final regionCode = await LocalePlus().getRegionCode();
final languageCode = await LocalePlus().getLanguageCode();
```

### Get Seconds from GMT

```Dart
final secondsFromGMT = await LocalePlus().getSecondsFromGMT();
```

### Is Device Using 24 hour time and Current Locale AM PM Symbols

```Dart
final is24HourTime = await LocalePlus().is24HourTime();
final amSymbol = await LocalePlus().getAmSymbol();
final pmSymbol = await LocalePlus().getPmSymbol();
```

### Is Device Using Metric System

```Dart
final usesMetricSystem = await LocalePlus().usesMetricSystem();
```

### Get TimeZone Identifier

```Dart
final timeZoneIdentifier = await LocalePlus().getTimeZoneIdentifier();
```

## Author

[Gökberk Bardakçı](https://www.github.com/gokberkbar), [Uygar İşiçelik](https://www.github.com/uygar)

## Contributors

[Bent Engbers](https://github.com/BentEngbers)

## License

LocalePlus is available under the MIT license. See the LICENSE file for more info.
