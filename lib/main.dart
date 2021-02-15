import 'dart:developer';

import 'package:flutter/material.dart';
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
  String _initialRoute = SettingsScreen.routeName;

  // Einlesen der gespeicherten Settings
  _MyAppState() {
    _settings.readFromFile();
    // Wenn das geklappt hat, wird initialized auf true gesetzt
    if (_settings.initialized) {
      log('Route gesetzt auf Calculator');
      _initialRoute = CalculatorScreen.routeName;
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: _initialRoute,
        routes: {
          CalculatorScreen.routeName: (context) => CalculatorScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
          ResultatScreen.routeName: (context) => ResultatScreen(),
        },
      );
}
