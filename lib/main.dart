import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plzcalculator/models/resultat.dart';
import 'package:plzcalculator/models/settings.dart';
import 'package:plzcalculator/screens/calculator_screen.dart';
import 'package:plzcalculator/screens/resultat_screen.dart';
import 'package:plzcalculator/screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

/// Applikation-Objekt
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Settings _settings = Settings();
  String _initialRoute;

  // Einlesen der gespeicherten Settings
  _MyAppState() {
    _settings.readFromFile();
    // Wenn das geklappt hat, wird initialized auf true gesetzt
    if (!_settings.initialized) {
      log('Route gesetzt auf Settings');
      _initialRoute = SettingsScreen.routeName;
    } else {
      log('Route gesetzt auf Calculator');
      _initialRoute = CalculatorScreen.routeName;
    }
  }

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: _initialRoute,
        // home: CalculatorScreen(),
        getPages: [
          GetPage(name: CalculatorScreen.routeName, page: () => CalculatorScreen()),
          GetPage(name: SettingsScreen.routeName, page: () => SettingsScreen()),
          GetPage(name: ResultatScreen.routeName, page: () => ResultatScreen(Resultat())),
        ],
      );
}
