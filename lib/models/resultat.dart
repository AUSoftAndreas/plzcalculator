import 'package:plzcalculator/models/settings.dart';

/// Das Ergebniss einer Routenabfrage
class Resultat {
  /// Die Distanz zwischen der startPlz und der zielPlz
  final int? fahrtstrecke;

  /// Die Zeit, die benötigt wird, um die Distanz zu überwinden
  final int? fahrtzeit;

  /// Ist true, wenn ein Fehler bei der Abfrage geschah, zum Beispiel 
  /// durch Verbindungsabbruch
  final bool error;

  /// Schriftliche Bezeichnung eines eventuellen Fehlers
  final String? errorMessage;

  /// Die Höhe der Fahrtkosten (gemäß Km-Pauschale) für die Strecke
  int fahrtkostenStrecke = 0;

  /// Die Höhe der Fahrtkosten (gemäß Stunden-Pauschale) für die Strecke
  int fahrtkostenZeit = 0;

  /// Die Höhe der Hotelkosten, so Hotelkosten anfallen
  int hotelkosten = 0;

  /// Die Summer aller Kosten
  int summe = 0;

  /// Die Höhe der Mehrwertsteuer
  int mwst = 0;

  /// Die Summe inklusive der Mehrwertsteuer
  int bruttosumme = 0;

  /// Konstruktor für das Ergebnis der Abfrage
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
