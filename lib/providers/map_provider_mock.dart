import 'dart:async';
import 'dart:math';

import 'package:plzcalculator/providers/map_provider_interface.dart';
import 'package:plzcalculator/models/eingabe.dart';
import 'package:plzcalculator/models/resultat.dart';

/// Liefert unabhängig von den Ausgangsdaten einigermaßen plausible Routendaten zurück
class MockMapProvider implements MapProvider {
  @override
  Future<Resultat> getResult(Eingabe eingabe) => Future.delayed(
        const Duration(seconds: 2),
        () {
          final rng = Random();
          final km = rng.nextInt(500) + 1;
          // ergibt eine km-Entfernung zwischen 1 und 500 km
          final tempo = rng.nextDouble() * 60 + 60;
          // ergibt eine D-Geschwindigkeit zwischen 60 und 120 km/h
          final fahrtzeit = (km / tempo * 3600).round();
          // ergibt entsprechend die Fahrtzeit (die * 60 wegen der Angabe in Minuten)

          return Resultat(
            fahrtstrecke: km * 1000,
            fahrtzeit: fahrtzeit,
          );
        },
      );
}
