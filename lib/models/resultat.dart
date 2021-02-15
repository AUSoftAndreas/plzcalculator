import 'package:plzcalculator/models/settings.dart';

/// Das Ergebniss der anfrage
class Resultat {
  // gegeben bei Konstruktion
  /// Die Distanz zwischen der startPlz und der zielPlz
  final int? fahrtstrecke;

  /// Die Zeit die benötigt wird um die Distanz zu überwinden
  final int? fahrtzeit;

  /// Ein Fehler
  final bool error;

  /// Schriftliche bezeichnung des Fehlers
  final String? errorMessage;
  // errechnet
  /// Die höhe der Kosten für die Strecke
  int fahrtkostenStrecke = 0;

  /// Die höhe der Fahrtkosten
  int fahrtkostenZeit = 0;

  /// Die höhe der Hotelkosten
  int hotelkosten = 0;

  /// Die Summer aller Kosten
  int summe = 0;

  /// Die höhe der Mehrwertsteuer
  int mwst = 0;

  /// Die summe zzgl der mwst.
  int bruttosumme = 0;

  /// Das Ergebniss der anfrage
  Resultat({
    this.fahrtstrecke,
    this.fahrtzeit,
    this.error = false,
    this.errorMessage,
  }) {
    final settings = Settings();
    if (fahrtstrecke == null || fahrtzeit == null) {
      return;
    }
    if (fahrtstrecke != null &&
        fahrtzeit != null &&
        errorMessage == null &&
        !error) {
      fahrtkostenStrecke =
          2 * fahrtstrecke!.round() * settings.fahrtkostenKm ~/ 1000;
      fahrtkostenZeit = (2 * fahrtzeit! * settings.fahrtkostenH) ~/ 3600;
      if (settings.hotel &&
          (fahrtstrecke! >= settings.hotelAbKm * 1000 ||
              fahrtzeit! >= settings.hotelAbH * 3600)) {
        hotelkosten = settings.hotelKosten;
      }
      summe = fahrtkostenStrecke + fahrtkostenZeit + hotelkosten;
      mwst = (summe * settings.mwstSatz / 100).round();
      bruttosumme = summe + mwst;
    }
  }
}
