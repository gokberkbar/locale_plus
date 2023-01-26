import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:locale_plus/locale_plus.dart';

extension on NumberSymbols {
  NumberSymbols overrideDecimalSeperator(String decimalSeparator) =>
      NumberSymbols(
          NAME: NAME,
          DECIMAL_SEP: decimalSeparator,
          GROUP_SEP: GROUP_SEP,
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
class PatchAllLocales {
  static Future<void> patchDecimalSeperator() async {
    try {
      final String? decimalSeperatorPlus =
          await LocalePlus().getDecimalSeparator();
      if (decimalSeperatorPlus == null) {
        return debugPrint('decimalSeperator could not be found');
      }
      final entries = numberFormatSymbols.entries;
      if (entries is! Iterable<MapEntry<String, NumberSymbols>>) {
        return debugPrint('''
numberFormat Symbols is the wrong type
please create an issue on https://github.com/gokberkbar/locale_plus''');
      }
      for (final MapEntry<String, NumberSymbols> n in entries) {
        numberFormatSymbols[n.key] =
            n.value.overrideDecimalSeperator(decimalSeperatorPlus);
      }
    } on MissingPluginException {
      final os = Platform.operatingSystem;
      debugPrint('''
This plugin is not implemented on $os.
Cannot patch the decial seperator''');
    }
  }
}
