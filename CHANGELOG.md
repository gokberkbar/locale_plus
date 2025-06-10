
# 1.7.0

- remove unused analysis options (#17)
- Relaxed [intl](https://pub.dev/packages/intl) package dependency for flutter version updates. Changed intl dependency version to ">=0.19.0 <0.21.0".
- Fix android warning: [deprecation] locale in Configuration has been deprecated

# 1.6.0+1

- README updated.

# 1.6.0

- Upgrade Dart SDK version from `2.16.2` to `3.0.0`.
- Upgrade Flutter SDK version from `2.5.0` to `3.10.o`.
- Update [intl](https://pub.dev/packages/intl) package from `0.18.0` to `0.19.0`.

# 1.5.0

- "namespace" added to build.gradle file.
- android package name changed.

# 1.4.1

- Enhanced the `isUsingSamsungKeyboard` native check to improve the Samsung keyboards recognition.

# 1.4.0

- Add the `getFirstDayOfWeek` function to getting the first day of week from a current locale on Android or from "Language & Region" settings on iOS.

# 1.3.1

- Update dependencies

# 1.3.0

- Add an additional check to make sure the decimal seperator and the group seperator are different.
- Remove the flags from `patchNumberSeperators` that would allow for seperate patching of the group and decimal seperator.
- remove the `shouldPatchLocales` flag from the `patchNumberSeperators`.

# 1.2.0

- Add the `isUsingSamsungKeyboard` function to detect if the user is using a samsung keyboard
- Add the `patchForSamsungKeyboards` argument to the `patchNumberSeperators` function, to chan

# 1.1.1

- Improve error reporting to the developer

# 1.1.0

- Add the `patchNumberSeperators` function to change decimal and group seperators on all locales.
- Get TimeZone Identifier feature implemented.

# 1.0.1

Authors updated.

# 1.0.0

Initial version release.
