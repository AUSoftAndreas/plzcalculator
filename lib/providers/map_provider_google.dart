import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plzcalculator/providers/map_provider_interface.dart';
import 'package:plzcalculator/models/eingabe.dart';
import 'package:plzcalculator/models/resultat.dart';

class GoogleMapProvider implements MapProvider {
  Future<Resultat> getResult(Eingabe eingabe) async {
    String zielPlz = eingabe.zielPlz;
    String startPlz = eingabe.startPlz;
    http.Client client = http.Client();
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$startPlz+Deutschland&destination=$zielPlz+Deutschland&key=AIzaSyAOhmbRSKBiyY3j3Nm03wYUl-tXot-Q_04';
    final http.Response response = await client.get(url);
    if (response.statusCode != 200) {
      return null;
    }
    String body = response.body;
    Map<String, dynamic> json = jsonDecode(body);
    if (json.containsKey('error_message')) {
      return Resultat(error: true, errorMessage: json['error_message']);
    } else {
      return Resultat(
        fahrtstrecke: json['routes'][0]['legs'][0]['distance']['value'],
        fahrtzeit: json['routes'][0]['legs'][0]['duration']['value'],
      );
    }
  }
}
