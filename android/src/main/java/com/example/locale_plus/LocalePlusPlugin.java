package com.example.locale_plus;

import android.content.Context;
import android.text.format.DateFormat;

import androidx.annotation.NonNull;

import java.text.DateFormatSymbols;
import java.text.DecimalFormatSymbols;
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

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    Locale currentLocale =  mContext.getResources().getConfiguration().locale;
    if (call.method.equals(MethodNames.getDecimalSeparator.getText())) {
      char decimalSeparator = DecimalFormatSymbols.getInstance(currentLocale).getDecimalSeparator();
      result.success(String.valueOf(decimalSeparator));
    }else if (call.method.equals(MethodNames.getGroupingSeparator.getText())) {
      char groupingSeparator = DecimalFormatSymbols.getInstance(currentLocale).getGroupingSeparator();
      result.success(String.valueOf(groupingSeparator));
    }else if (call.method.equals(MethodNames.getSecondsFromGMT.getText())) {
      int secondsFromGmt = TimeZone.getDefault().getRawOffset() / 1000;
      result.success(secondsFromGmt);
    }else if (call.method.equals(MethodNames.getRegionCode.getText())) {
      String regionCode = currentLocale.getCountry();
      result.success(regionCode);
    }else if (call.method.equals(MethodNames.getLanguageCode.getText())) {
      String languageCode = currentLocale.getLanguage();
      result.success(languageCode);
    }else if (call.method.equals(MethodNames.usesMetricSystem.getText())) {
      result.success(usesMetricSystem(currentLocale));
    }else if (call.method.equals(MethodNames.is24HourTime.getText())) {
      boolean is24HourTime = DateFormat.is24HourFormat(mContext);
      result.success(is24HourTime);
    } else if (call.method.equals(MethodNames.getAmSymbol.getText())) {
      String[] amPmStrings = DateFormatSymbols.getInstance(currentLocale).getAmPmStrings();
      if (amPmStrings.length > 0) {
        result.success(amPmStrings[0]);
      }else {
        result.success(null);
      }
    } else if (call.method.equals(MethodNames.getPmSymbol.getText())) {
      String[] amPmStrings = DateFormatSymbols.getInstance(currentLocale).getAmPmStrings();
      if (amPmStrings.length > 0) {
        result.success(amPmStrings[amPmStrings.length - 1]);
      }else {
        result.success(null);
      }
    }
    else if (call.method.equals(MethodNames.getTimeZoneIdentifier.getText())){
      String timeZoneIdentifier = TimeZone.getDefault().getID();
      result.success(timeZoneIdentifier);
    }
    else {
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

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
