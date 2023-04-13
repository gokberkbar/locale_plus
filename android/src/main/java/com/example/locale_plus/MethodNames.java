package com.example.locale_plus;

public enum MethodNames {
    getGroupingSeparator("getGroupingSeparator"),
    getDecimalSeparator("getDecimalSeparator"),
    getSecondsFromGMT("getSecondsFromGMT"),
    getRegionCode("getRegionCode"),
    getLanguageCode("getLanguageCode"),
    usesMetricSystem("usesMetricSystem"),
    getTemperatureUnit("getTemperatureUnit"),
    getHourCycle("getHourCycle"),
    getAmSymbol("getAmSymbol"),
    getPmSymbol("getPmSymbol"),
    getTimeZoneIdentifier("getTimeZoneIdentifier");

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