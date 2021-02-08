import 'package:plzcalculator/models/settings.dart';

/// Diese Klasse fasst alle Daten zu einer konkreten Suchanfrage zusammen
class Eingabe {
  String _zielPlz;
  String _startPlz = Settings().ausgangsort;

  Eingabe(String zielPlz) : _zielPlz = zielPlz;

  /// PLZ des Zielortes
  String get zielPlz => _zielPlz;

  /// PLZ des Ausgangsortes
  String get startPlz => _startPlz;
}
