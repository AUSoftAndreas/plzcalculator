import 'package:plzcalculator/models/settings.dart';

/// Diese Klasse fasst alle Daten zu einer konkreten Suchanfrage zusammen
class Eingabe {
  final String _zielPlz;
  final String _startPlz = Settings().ausgangsort;

  /// Konstruktor der Klasse Eingabe
  /// Die Ziel-PLZ kann/muss bestimmt werden bei Konstruktion des Objektes
  Eingabe(String zielPlz) : _zielPlz = zielPlz;

  /// PLZ des Zielortes
  String get zielPlz => _zielPlz;

  /// PLZ des Ausgangsortes
  String get startPlz => _startPlz;
}
