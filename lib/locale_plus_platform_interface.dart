import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'locale_plus_method_channel.dart';

abstract class LocalePlusPlatform extends PlatformInterface {
  LocalePlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static LocalePlusPlatform _instance = MethodChannelLocalePlus();

  static LocalePlusPlatform get instance => _instance;

  static set instance(LocalePlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDecimalSeparator() {
    throw UnimplementedError('getDecimalSeparator() has not been implemented.');
  }

  Future<String?> getGroupingSeparator() {
    throw UnimplementedError(
        'getGroupingSeparator() has not been implemented.');
  }

  Future<int?> getSecondsFromGMT() {
    throw UnimplementedError('getSecondsFromGMT() has not been implemented.');
  }

  Future<String?> getRegionCode() {
    throw UnimplementedError('getRegionCode() has not been implemented.');
  }

  Future<String?> getLanguageCode() {
    throw UnimplementedError('getLanguageCode() has not been implemented.');
  }

  Future<bool?> usesMetricSystem() {
    throw UnimplementedError('usesMetricSystem() has not been implemented.');
  }

  Future<bool?> is24HourTime() {
    throw UnimplementedError('is24HourTime() has not been implemented.');
  }

  Future<String?> getAmSymbol() {
    throw UnimplementedError('getAmSymbol() has not been implemented.');
  }

  Future<String?> getPmSymbol() {
    throw UnimplementedError('getPmSymbol() has not been implemented.');
  }

  Future<String?> getTimeZoneIdentifier() {
    throw UnimplementedError(
        'getTimeZoneIdentifier() has not been implemented.');
  }
}
