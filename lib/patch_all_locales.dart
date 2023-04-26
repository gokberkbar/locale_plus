import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:locale_plus/locale_plus.dart';

extension on NumberSymbols {
  NumberSymbols overrideDecimalSeperator(
          {String? decimalSeparator, String? groupingSeparator}) =>
      NumberSymbols(
          NAME: NAME,
          DECIMAL_SEP: decimalSeparator ?? DECIMAL_SEP,
          GROUP_SEP: groupingSeparator ?? GROUP_SEP,
          PERCENT: PERCENT,
          ZERO_DIGIT: ZERO_DIGIT,
          PLUS_SIGN: PLUS_SIGN,
          MINUS_SIGN: MINUS_SIGN,
          EXP_SYMBOL: EXP_SYMBOL,
          PERMILL: PERMILL,
          INFINITY: INFINITY,
          NAN: NAN,
          DECIMAL_PATTERN: DECIMAL_PATTERN,
          SCIENTIFIC_PATTERN: SCIENTIFIC_PATTERN,
          PERCENT_PATTERN: PERCENT_PATTERN,
          CURRENCY_PATTERN: CURRENCY_PATTERN,
          DEF_CURRENCY_CODE: DEF_CURRENCY_CODE);
}

// ignore: avoid_classes_with_only_static_members
///The [PatchAllLocales] exposes async functions
///to patch the locales in [numberFormatSymbols].
class PatchAllLocales {
  ///Finds the correct decimal seperator
  static Future<String?> _getDecimalSeperator(LocalePlus localePlus,
      {required bool patchDecimal, required patchForSamsungKeyboards}) async {
    if (!patchDecimal) {
      return null;
    }
    if (patchForSamsungKeyboards) {
      final isUsingSamsungKeyboard = await localePlus.isUsingSamsungKeyboard();
      if (isUsingSamsungKeyboard != null && isUsingSamsungKeyboard) {
        return '.';
      }
    }
    return await localePlus.getDecimalSeparator();
  }

  static Future<String?> _getGroupingSeparator(LocalePlus localePlus,
      {required bool patchGroup,
      required bool patchForSamsungKeyboards}) async {
    if (!patchGroup) {
      return null;
    }
    if (patchForSamsungKeyboards) {
      final isUsingSamsungKeyboard = await localePlus.isUsingSamsungKeyboard();
      if (isUsingSamsungKeyboard != null && isUsingSamsungKeyboard) {
        return ',';
      }
    }
    return await localePlus.getGroupingSeparator();
  }

  ///[patchNumberSeperators] patches all locales with the
  ///decimal seperators to the decimal separator of the user.
  ///Patching the [DECIMAL_SEP] and [GROUP_SEP] can be disabled,
  ///by changing the [shouldPatchLocales] to false.
  ///The locales can also be patched for users with a samsung keyboard.
  /// This is done by changing the [patchForSamsungKeyboards] to true.
  /// The samsung keyboard always uses a '.' as input.
  /// see https://github.com/flutter/flutter/issues/61175

  static Future<void> patchNumberSeperators(
      {required bool shouldPatchLocales,
      bool patchForSamsungKeyboards = false}) async {
    final localePlus = LocalePlus();
    if (!shouldPatchLocales) {
      return debugPrint('''
shouldPatchLocales is disabled.
The locales are not patched.
''');
    }
    try {
      final userDecimalSeperator = await _getDecimalSeperator(localePlus,
          patchDecimal: shouldPatchLocales,
          patchForSamsungKeyboards: patchForSamsungKeyboards);

      final String? groupingSeperator = await _getGroupingSeparator(localePlus,
          patchGroup: shouldPatchLocales,
          patchForSamsungKeyboards: patchForSamsungKeyboards);
      if (userDecimalSeperator == '.' && groupingSeperator == ',' ||
          userDecimalSeperator == ',' && groupingSeperator == '.') {
        return debugPrint('''
locale_plus: The group seperator and decimalSeperator are the same. 
the locales are not patched.
decimal seperator: $userDecimalSeperator
group seperator: $groupingSeperator
''');
      }
      if (userDecimalSeperator == null || groupingSeperator == null) {
        return debugPrint('''
The decimalSeperator and/or groupingSeperator can not be found.
The locales are not patched.
        ''');
      }
      final entries = numberFormatSymbols.entries;
      if (entries is! Iterable<MapEntry<String, NumberSymbols>>) {
        return debugPrint('''
numberFormat Symbols is the wrong type
please create an issue on https://github.com/gokberkbar/locale_plus''');
      }
      for (final MapEntry<String, NumberSymbols> n in entries) {
        numberFormatSymbols[n.key] = n.value.overrideDecimalSeperator(
            decimalSeparator: userDecimalSeperator,
            groupingSeparator: groupingSeperator);
      }
    } on MissingPluginException {
      debugPrint(
          '''locale_plus: plugin is not implemented on $os. The locales are not patched.''');
    }
  }
}
