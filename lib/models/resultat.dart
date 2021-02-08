import 'package:flutter/foundation.dart';
import 'package:plzcalculator/models/settings.dart';

class Resultat {
  // gegeben bei Konstruktion
  final int? fahrtstrecke;
  final int? fahrtzeit;
  final bool error;
  final String? errorMessage;
  // errechnet
  int fahrtkostenStrecke = 0;
  int fahrtkostenZeit = 0;
  int hotelkosten = 0;
  int summe = 0;
  int mwst = 0;
  int bruttosumme = 0;

  Resultat({
    this.fahrtstrecke,
    this.fahrtzeit,
    this.error = false,
    this.errorMessage,
  }) {
    Settings settings = Settings();
    if (fahrtstrecke == null || fahrtzeit == null) {
      return;
    }
    if (fahrtstrecke != null && fahrtzeit != null && errorMessage == null && !error) {
      fahrtkostenStrecke = 2 * fahrtstrecke!.round() * settings.fahrtkostenKm ~/ 1000;
      fahrtkostenZeit = (2 * fahrtzeit! * settings.fahrtkostenH) ~/ 3600;
      if (settings.hotel && (fahrtstrecke! >= settings.hotelAbKm * 1000 || fahrtzeit! >= settings.hotelAbH * 3600)) {
        hotelkosten = settings.hotelKosten;
      }
      summe = fahrtkostenStrecke + fahrtkostenZeit + hotelkosten;
      mwst = (summe * settings.mwstSatz / 100).round();
      bruttosumme = summe + mwst;
    }
  }
}
