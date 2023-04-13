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
  ///[patchNumberSeperators] patches all locales with the
  ///decimal seperators to the decimal separator of the user.
  ///Patching the [DECIMAL_SEP] can be disabled,
  ///by changing the [patchDecimal] to false.
  ///Patching the [GROUP_SEP] can be disabled,
  ///by changing the [patchGroup] to false.
  static Future<void> patchNumberSeperators(
      {bool patchDecimal = true, bool patchGroup = true}) async {
    final localePlus = LocalePlus();
    if (!patchDecimal && !patchGroup) {
      return debugPrint('''
Both patchDecimal and patchGroup are disabled.
The locales are not patched.
''');
    }
    try {
      final String? userDecimalSeperator =
          patchDecimal ? (await localePlus.getDecimalSeparator()) : null;
      final String? groupingSeperator =
          patchGroup ? (await localePlus.getGroupingSeparator()) : null;

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
