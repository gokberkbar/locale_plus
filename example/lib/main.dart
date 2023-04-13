import 'package:flutter/material.dart';
import 'dart:async';

import 'package:locale_plus/locale_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PatchAllLocales.patchNumberSeperators();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? decimalSeparator;
  String? groupingSeparator;
  int? secondsFromGMT;
  String? regionCode;
  String? languageCode;
  bool? usesMetricSystem;
  HourCycle? hourCycle;
  String? amSymbol;
  String? pmSymbol;
  String? timeZoneIdentifier;
  TemperatureUnit? temperatureUnit;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    decimalSeparator = await LocalePlus().getDecimalSeparator();
    groupingSeparator = await LocalePlus().getGroupingSeparator();
    secondsFromGMT = (await LocalePlus().getOffsetFromGMT())?.inSeconds;
    regionCode = await LocalePlus().getRegionCode();
    languageCode = await LocalePlus().getLanguageCode();
    usesMetricSystem = await LocalePlus().usesMetricSystem();
    hourCycle = await LocalePlus().getHourCycle();
    amSymbol = await LocalePlus().getAmSymbol();
    pmSymbol = await LocalePlus().getPmSymbol();
    timeZoneIdentifier = await LocalePlus().getTimeZoneIdentifier();
    temperatureUnit = await LocalePlus().getTemperatureUnit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Decimal Separator: $decimalSeparator',
                textAlign: TextAlign.center,
              ),
              Text(
                'Grouping Separator: $groupingSeparator',
                textAlign: TextAlign.center,
              ),
              Text(
                'Seconds From GMT: $secondsFromGMT',
                textAlign: TextAlign.center,
              ),
              Text(
                'Region Code: $regionCode',
                textAlign: TextAlign.center,
              ),
              Text(
                'Language Code: $languageCode',
                textAlign: TextAlign.center,
              ),
              Text(
                'Uses Metric System: $usesMetricSystem',
                textAlign: TextAlign.center,
              ),
              Text(
                'Is 24 Hour Time: $hourCycle',
                textAlign: TextAlign.center,
              ),
              Text(
                'AM Symbol: $amSymbol',
                textAlign: TextAlign.center,
              ),
              Text(
                'PM Symbol: $pmSymbol',
                textAlign: TextAlign.center,
              ),
              Text(
                'Time Zone Identifier: $timeZoneIdentifier',
                textAlign: TextAlign.center,
              ),
              Text(
                'Temperature Unit: ${temperatureUnit?.symbol}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
