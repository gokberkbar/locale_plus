import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:locale_plus/locale_plus.dart';

extension on NumberSymbols {
  NumberSymbols overrideSeperators({
    String? decimalSeparator,
    String? groupingSeparator,
  }) =>
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
        DEF_CURRENCY_CODE: DEF_CURRENCY_CODE,
      );
}

// ignore: avoid_classes_with_only_static_members
///The [PatchAllLocales] exposes async functions
///to patch the locales in [numberFormatSymbols].
class PatchAllLocales {
  /// [patchNumberSeperators] patches all locales with the
  /// decimal seperators to the decimal separator of the user.
  /// The locales can also be patched for users with a samsung keyboard.
  /// This is done by changing the [patchForSamsungKeyboards] to true.
  /// The samsung keyboard always uses a '.' as input for a decimal seperator.
  /// This means that the [DECIMAL_SEP] is a '.' and the [GROUP_SEP] is a ','
  /// see https://github.com/flutter/flutter/issues/61175
  static Future<void> patchNumberSeperators({
    bool patchForSamsungKeyboards = false,
  }) async {
    final localePlus = LocalePlus();
    try {
      final bool isUsingSamsungKeyboard = patchForSamsungKeyboards &&
          (await localePlus.isUsingSamsungKeyboard() ?? false);

      final String? userDecimalSeperator =
          isUsingSamsungKeyboard ? '.' : await localePlus.getDecimalSeparator();

      final String? userGroupingSeperator = isUsingSamsungKeyboard
          ? ','
          : await localePlus.getGroupingSeparator();

      if (userDecimalSeperator == null || userGroupingSeperator == null) {
        return debugPrint('''
The decimalSeperator and/or groupingSeperator can not be found.
The locales are not patched.
        ''');
      }
      if (userDecimalSeperator == userGroupingSeperator) {
        return debugPrint('''
locale_plus: The group seperator and decimalSeperator are the same. 
the locales are not patched.
decimal seperator: $userDecimalSeperator
group seperator: $userGroupingSeperator
''');
      }
      final entries = numberFormatSymbols.entries;
      for (final MapEntry<String, NumberSymbols> n in entries) {
        numberFormatSymbols[n.key] = n.value.overrideSeperators(
          decimalSeparator: userDecimalSeperator,
          groupingSeparator: userGroupingSeperator,
        );
      }
    } on MissingPluginException {
      debugPrint(
          '''locale_plus: plugin is not implemented on $os. The locales are not patched.''');
    }
  }
}
