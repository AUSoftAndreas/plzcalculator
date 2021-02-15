import 'package:plzcalculator/providers/map_provider_google.dart';
import 'package:plzcalculator/models/eingabe.dart';
import 'package:plzcalculator/models/resultat.dart';

/// Interface für MapProvider
abstract class MapProvider {
  /// Muster für Anfrage für Rohdaten
  Future<Resultat> getResult(Eingabe eingabe);

  /// Gegenwärtig eingestellter Provider
  factory MapProvider() => GoogleMapProvider();
}
