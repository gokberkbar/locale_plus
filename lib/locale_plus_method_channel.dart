import 'package:flutter/services.dart';

import 'locale_plus_platform_interface.dart';

class MethodChannelLocalePlus extends LocalePlusPlatform {
  final methodChannel = const MethodChannel('locale_plus');

  @override
  Future<String?> getDecimalSeparator() async {
    final decimalSeparator =
        await methodChannel.invokeMethod<String>('getDecimalSeparator');
    return decimalSeparator;
  }

  @override
  Future<String?> getGroupingSeparator() async {
    final groupingSeparator =
        await methodChannel.invokeMethod<String>('getGroupingSeparator');
    return groupingSeparator;
  }

  @override
  Future<int?> getSecondsFromGMT() async {
    final secondsFromGMT =
        await methodChannel.invokeMethod<int>('getSecondsFromGMT');
    return secondsFromGMT;
  }

  @override
  Future<String?> getRegionCode() async {
    final regionCode =
        await methodChannel.invokeMethod<String>('getRegionCode');
    return regionCode;
  }

  @override
  Future<String?> getLanguageCode() async {
    final languageCode =
        await methodChannel.invokeMethod<String>('getLanguageCode');
    return languageCode;
  }

  @override
  Future<bool?> usesMetricSystem() async {
    final usesMetricSystem =
        await methodChannel.invokeMethod<bool>('usesMetricSystem');
    return usesMetricSystem;
  }

  @override
  Future<int?> getTemperatureUnit() async {
    final temperatureUnit =
        await methodChannel.invokeMethod<int>('getTemperatureUnit');
    return temperatureUnit;
  }

  @override
  Future<String?> getHourCycle() =>
      methodChannel.invokeMethod<String>('getHourCycle');

  @override
  Future<String?> getAmSymbol() async {
    final amSymbol = await methodChannel.invokeMethod<String>('getAmSymbol');
    return amSymbol;
  }

  @override
  Future<String?> getPmSymbol() async {
    final pmSymbol = await methodChannel.invokeMethod<String>('getPmSymbol');
    return pmSymbol;
  }

  @override
  Future<String?> getTimeZoneIdentifier() async {
    final timeZoneIdentifier =
        await methodChannel.invokeMethod<String>('getTimeZoneIdentifier');
    return timeZoneIdentifier;
  }
}
