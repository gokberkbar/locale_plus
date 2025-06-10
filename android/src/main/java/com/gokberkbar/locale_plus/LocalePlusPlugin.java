package com.gokberkbar.locale_plus;

import android.content.Context;
import android.os.Build;
import android.provider.Settings;
import android.text.format.DateFormat;
import android.view.inputmethod.InputMethodManager;
import android.content.res.Configuration;

import androidx.annotation.NonNull;

import java.text.DateFormatSymbols;
import java.text.DecimalFormatSymbols;
import java.time.temporal.WeekFields;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class LocalePlusPlugin implements FlutterPlugin, MethodCallHandler {

  private MethodChannel channel;
  private Context mContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    mContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "locale_plus");
    channel.setMethodCallHandler(this);
  }

  private boolean usingKeyboard(@NonNull String keyboardId) {
    final InputMethodManager richImm = (InputMethodManager) mContext.getSystemService(Context.INPUT_METHOD_SERVICE);
    String defaultKeyboard = Settings.Secure.getString(mContext.getContentResolver(),
        Settings.Secure.DEFAULT_INPUT_METHOD);
    if (defaultKeyboard == null) {
      return false;
    } else {
      defaultKeyboard = defaultKeyboard.toLowerCase();
    }
    return defaultKeyboard.contains(keyboardId.toLowerCase());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    Configuration config = mContext.getResources().getConfiguration();
    Locale currentLocale;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      currentLocale = config.getLocales().get(0);
    } else {
      currentLocale = config.locale;
    }

    if (call.method.equals(MethodNames.getDecimalSeparator.getText())) {
      char decimalSeparator = DecimalFormatSymbols.getInstance(currentLocale).getDecimalSeparator();
      result.success(String.valueOf(decimalSeparator));
    } else if (call.method.equals(MethodNames.getGroupingSeparator.getText())) {
      char groupingSeparator = DecimalFormatSymbols.getInstance(currentLocale).getGroupingSeparator();
      result.success(String.valueOf(groupingSeparator));
    } else if (call.method.equals(MethodNames.getSecondsFromGMT.getText())) {
      int secondsFromGmt = TimeZone.getDefault().getRawOffset() / 1000;
      result.success(secondsFromGmt);
    } else if (call.method.equals(MethodNames.getRegionCode.getText())) {
      String regionCode = currentLocale.getCountry();
      result.success(regionCode);
    } else if (call.method.equals(MethodNames.getLanguageCode.getText())) {
      String languageCode = currentLocale.getLanguage();
      result.success(languageCode);
    } else if (call.method.equals(MethodNames.usesMetricSystem.getText())) {
      result.success(usesMetricSystem(currentLocale));
    } else if (call.method.equals(MethodNames.is24HourTime.getText())) {
      boolean is24HourTime = DateFormat.is24HourFormat(mContext);
      result.success(is24HourTime);
    } else if (call.method.equals(MethodNames.getAmSymbol.getText())) {
      String[] amPmStrings = DateFormatSymbols.getInstance(currentLocale).getAmPmStrings();
      if (amPmStrings.length > 0) {
        result.success(amPmStrings[0]);
      } else {
        result.success(null);
      }
    } else if (call.method.equals(MethodNames.getPmSymbol.getText())) {
      String[] amPmStrings = DateFormatSymbols.getInstance(currentLocale).getAmPmStrings();
      if (amPmStrings.length > 0) {
        result.success(amPmStrings[amPmStrings.length - 1]);
      } else {
        result.success(null);
      }
    } else if (call.method.equals(MethodNames.getTimeZoneIdentifier.getText())) {
      String timeZoneIdentifier = TimeZone.getDefault().getID();
      result.success(timeZoneIdentifier);
    } else if (call.method.equals(MethodNames.isUsingSamsungKeyboard.getText())) {
      result.success(usingKeyboard("samsung"));
    } else if (call.method.equals(MethodNames.getFirstDayOfWeek.getText())) {
      result.success(getFirstDayOfWeek(currentLocale));
    } else {
      result.notImplemented();
    }
  }

  private boolean usesMetricSystem(Locale locale) {
    String countryCode = locale.getCountry();
    switch (countryCode) {
      case "US":
      case "LR":
      case "MM":
        return false;
      default:
        return true;
    }
  }

  private int getFirstDayOfWeek(Locale locale) {
    if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      WeekFields weekFields = WeekFields.of(locale);
      return weekFields.getFirstDayOfWeek().getValue();
    } else {
      Calendar cal = Calendar.getInstance(locale);
      int firstDayOfWeek = cal.getFirstDayOfWeek();
      if (firstDayOfWeek == 1) {
        return 7;
      } else {
        return firstDayOfWeek - 1;
      }
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
