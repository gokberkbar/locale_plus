package com.example.locale_plus;

public enum MethodNames {
    getGroupingSeparator("getGroupingSeparator"),
    getDecimalSeparator("getDecimalSeparator"),
    getSecondsFromGMT("getSecondsFromGMT"),
    getRegionCode("getRegionCode"),
    getLanguageCode("getLanguageCode"),
    usesMetricSystem("usesMetricSystem"),
    is24HourTime("is24HourTime"),
    getAmSymbol("getAmSymbol"),
    getPmSymbol("getPmSymbol"),
    getTimeZoneIdentifier("getTimeZoneIdentifier"),
    isUsingSamsungKeyboard("isUsingSamsungKeyboard"),
    getFirstDayOfWeek("getFirstDayOfWeek");

    private final String text;

    MethodNames(String text) {
        this.text = text;
    }

    public String getText() {
        return this.text;
    }

    public static MethodNames fromString(String text) {
        for (MethodNames b : MethodNames.values()) {
            if (b.text.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }
}