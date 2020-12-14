import 'package:plzcalculator/controller/map_provider_mock.dart';
import 'package:plzcalculator/models/eingabe.dart';
import 'package:plzcalculator/models/resultat.dart';

abstract class MapProvider {
  Future<Resultat> getResult(Eingabe eingabe);

  factory MapProvider() => MockMapProvider();
}
