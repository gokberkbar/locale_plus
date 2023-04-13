import 'locale_plus_platform_interface.dart';
export 'patch_all_locales.dart' show PatchAllLocales;

/// Locale plus is an easy way to get native devices Locale data.
class LocalePlus {
  /// Returns the decimal separator for the current locale of device.
  Future<String?> getDecimalSeparator() {
    return LocalePlusPlatform.instance.getDecimalSeparator();
  }

  /// Returns the grouping separator for the current locale of device.
  Future<String?> getGroupingSeparator() {
    return LocalePlusPlatform.instance.getGroupingSeparator();
  }

  /// Returns the seconds from GMT for the current locale of device.
  Future<Duration?> getOffsetFromGMT() async {
    final seconds = await LocalePlusPlatform.instance.getSecondsFromGMT();
    if (seconds == null) return null;
    return Duration(seconds: seconds);
  }

  /// Returns the region code for the current locale of device.
  Future<String?> getRegionCode() {
    return LocalePlusPlatform.instance.getRegionCode();
  }

  /// Returns the language code for the current locale of device.
  Future<String?> getLanguageCode() {
    return LocalePlusPlatform.instance.getLanguageCode();
  }

  /// Returns true if the device uses Metric System.
  Future<bool?> usesMetricSystem() {
    return LocalePlusPlatform.instance.usesMetricSystem();
  }

  /// returns the preferred temperature of the device.
  Future<TemperatureUnit?> getTemperatureUnit() async {
    try {
      final unit = (await LocalePlusPlatform.instance.getTemperatureUnit())!;
      return TemperatureUnit.values[unit];
    } catch (e) {
      final usesMetricSystem = await this.usesMetricSystem();
      if (usesMetricSystem == null) return null;
      return usesMetricSystem
          ? TemperatureUnit.celsius
          : TemperatureUnit.fahrenheit;
    }
  }

  /// Returns true if the device uses 24 hour time.
  Future<HourCycle?> getHourCycle() async {
    final hourCycle = await LocalePlusPlatform.instance.getHourCycle();
    if (hourCycle == null) return null;
    return HourCycleExtension.fromName(hourCycle);
  }

  /// Returns the AM symbol for the current locale of device.
  Future<String?> getAmSymbol() {
    return LocalePlusPlatform.instance.getAmSymbol();
  }

  /// Returns the PM symbol for the current locale of device.
  Future<String?> getPmSymbol() {
    return LocalePlusPlatform.instance.getPmSymbol();
  }

  /// Returns the time zone identifier for the current locale of device.
  Future<String?> getTimeZoneIdentifier() {
    return LocalePlusPlatform.instance.getTimeZoneIdentifier();
  }
}

enum TemperatureUnit { celsius, fahrenheit }

extension TemperatureUnitExtension on TemperatureUnit {
  String get name {
    switch (this) {
      case TemperatureUnit.celsius:
        return 'Celsius';
      case TemperatureUnit.fahrenheit:
        return 'Fahrenheit';
    }
  }

  String get symbol {
    switch (this) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
    }
  }
}

enum HourCycle { h12, h24, h11, h23 }

extension HourCycleExtension on HourCycle {
  String get name {
    switch (this) {
      case HourCycle.h12:
        return 'h12';
      case HourCycle.h24:
        return 'h24';
      case HourCycle.h11:
        return 'h11';
      case HourCycle.h23:
        return 'h23';
    }
  }

  static HourCycle? fromName(String name) {
    switch (name) {
      case 'h12':
        return HourCycle.h12;
      case 'h24':
        return HourCycle.h24;
      case 'h11':
        return HourCycle.h11;
      case 'h23':
        return HourCycle.h23;
      default:
        return null;
    }
  }
}
