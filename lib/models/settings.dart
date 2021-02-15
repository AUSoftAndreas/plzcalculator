/// Die Klasse fasst alle parameter zu einer konkreten Suchanfrage zusammen
class Settings {
  //==========================================================================//
  // Attribute, Getters, Setters                                              //
  //==========================================================================//
  String _ausgangsort = '';
  int _fahrtkostenH = 5000;
  int _fahrtkostenKm = 49;
  bool _hotel = true;
  int _hotelKosten = 5000;
  int _hotelAbKm = 150;
  int _hotelAbH = 3;
  int _mwstSatz = 16;

  static final Settings _singleton = Settings._internal();

  /// Wurden die Settings mind. 1x bereits bearbeitet
  bool initialized = false;

  /// Start Ort/Gebiet
  String get ausgangsort => _ausgangsort;

  /// Fahrt Kosten für die Ausführende Person (Stundenlohn der fahrt)
  int get fahrtkostenH => _fahrtkostenH;

  /// Kosten der fahrt für den Transport der Person (Sprit)
  int get fahrtkostenKm => _fahrtkostenKm;

  /// Das ausgewählte Hotel
  bool get hotel => _hotel;

  /// Die Hotelkosten
  int get hotelKosten => _hotelKosten;

  /// Ab wie viel Km man ein Hotel einkalkuliert
  int get hotelAbKm => _hotelAbKm;

  ///
  int get hotelAbH => _hotelAbH;

  /// Die höhe der Gesetzlich festgelegten mwst
  int get mwstSatz => _mwstSatz;

  set hotel(bool hotel) {
    _hotel = hotel;
    initialized = true;
  }

  //==========================================================================//
  // Konstruktoren                                                            //
  //==========================================================================//
  /// Der externe Konstruktor gibt immer nur den Verweis auf das einmalig
  /// instanzierte Objekt zurück. Es handelt sich um ein Singleton, also das
  /// Erzeugen eines weiteren Setting-Objektes wird unterbunden
  factory Settings() => _singleton;

  // Der interne Konstruktor (wird nur einmal aufgerufen, initialisiert das
  // Objekt, ist hier aber ohne Funktion, weil wir alle Initialisierungen
  // oben bei den Attributen vornehmen)
  Settings._internal();

  //==========================================================================//
  // Methoden                                                                 //
  //==========================================================================//
  /// Beziehen aus der Datei
  void readFromFile() {
    // TODO: Muss noch implementiert werden
    //initialized = false;
  }

  /// Speichern in der Datei
  void saveToFile() {
    // TODO: Muss noch implementiert werden
  }

  // Die folgenden "Pseudo-Setter" haben nur die Funktion, dass sie Methoden
  // definieren, mit denen man o.a. Attribute setzen kann. Das hat den einen
  // Vorteil, das man einen Verweis auf diese Funktionen als Argument übergeben
  // kann. Das passiert vor allem im Settings-Screen
  // Der Parameter ist jeweils ein String, weil das vom Textfeld so übergeben wird
  /// Bestimmung des Ausgangsorts
  void setAusgangsort(String ausgangsort) {
    _ausgangsort = ausgangsort;
    initialized = true;
    saveToFile();
  }

  /// Die Errechneten Fahrtkosten der Distanz
  void setFahrtkostenKm(String strFahrtkostenKm) {
    // Zuerst werden alle , durch . ersetzt. Das Ergebnis ist eine interpretierbare
    // Kommazahl. Das wird mal 100 genommen, weil uns die Cents interessieren
    // Zum Ende wird (eigentlich ohne Effekt, wenn es keine Rechenfehler gibt)
    // gerundet, weil wir einen int-Wert wollen
    final fahrtkostenKm =
        (double.parse(strFahrtkostenKm.replaceAll(',', '.')) * 100).round();
    _fahrtkostenKm = fahrtkostenKm;
    initialized = true;
    saveToFile();
  }

  /// Die Errechneten Fahrtkosten der Personenkosten
  void setFahrtkostenH(String strFahrtkostenH) {
    // siehe setFahrtkostenKm
    final fahrtkostenH =
        (double.parse(strFahrtkostenH.replaceAll(',', '.')) * 100).round();
    _fahrtkostenH = fahrtkostenH;
    initialized = true;
    saveToFile();
  }

  /// Festsetzung der Hotelkosten
  void setHotelKosten(String strHotelKosten) {
    // siehe setFahrtkostenKm
    final hotelKosten =
        (double.parse(strHotelKosten.replaceAll(',', '.')) * 100).round();
    _hotelKosten = hotelKosten;
    initialized = true;
    saveToFile();
  }

  /// Ab welcher Distanz ein Hotel benötigt wird
  void setHotelAbKm(String strHotelAbKm) {
    // siehe setFahrtkostenKm, allerdings ohne den x100-Faktor
    final hotelAbKm = double.parse(strHotelAbKm.replaceAll(',', '.')).round();
    _hotelAbKm = hotelAbKm;
    initialized = true;
    saveToFile();
  }

  /// Ab welcher Fahrtdauer ein Hotel benötigt wird
  void setHotelAbH(String strHotelAbH) {
    // siehe setFahrtkostenKm, allerdings ohne den x100-Faktor
    final hotelAbH = double.parse(strHotelAbH.replaceAll(',', '.')).round();
    _hotelAbH = hotelAbH;
    initialized = true;
    saveToFile();
  }

  /// Die höhe der mwst der Netto kalkulation
  void setMwstSatz(String strMwstSatz) {
    // siehe setFahrtkostenKm, allerdings ohne den x100-Faktor
    final mwstSatz = double.parse(strMwstSatz.replaceAll(',', '.')).round();
    _mwstSatz = mwstSatz;
    initialized = true;
    saveToFile();
  }
}
