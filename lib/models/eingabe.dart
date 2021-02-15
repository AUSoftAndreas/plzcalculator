import 'package:plzcalculator/models/settings.dart';

/// Diese Klasse fasst alle Daten zu einer konkreten Suchanfrage zusammen
class Eingabe {
  final String _zielPlz;
  final String _startPlz = Settings().ausgangsort;

  /// Diese Klasse fasst die Daten zusammen mit einer konkreten zielPlz
  Eingabe(String zielPlz) : _zielPlz = zielPlz;

  /// PLZ des Zielortes
  String get zielPlz => _zielPlz;

  /// PLZ des Ausgangsortes
  String get startPlz => _startPlz;
}
