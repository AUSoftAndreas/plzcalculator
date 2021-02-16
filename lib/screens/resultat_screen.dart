import 'package:flutter/material.dart';
import 'package:plzcalculator/models/resultat.dart';
import 'package:plzcalculator/screens/settings_screen.dart';

/// Screen für die Ergebnisanzeige
class ResultatScreen extends StatelessWidget {
  /// Route zum Screen der Ergebnisanzeige
  static String routeName = '/resultat';

  /// Constructor für den Resultatscreen
  const ResultatScreen();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_as
    final _resultat = ModalRoute.of(context)?.settings.arguments as Resultat;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: MediaQuery.of(context).orientation == Orientation.landscape
          ? _buildBodyLandscape(_resultat)
          : _buildBodyPortrait(_resultat),
    );
  }

  SingleChildScrollView _buildBodyPortrait(Resultat _resultat) =>
      SingleChildScrollView(
        child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Angaben zur Strecke'),
              _buildCard(
                'km',
                '${(_resultat.fahrtstrecke ?? 0) ~/ 1000} km',
              ),
              _buildCard('Zeit',
                  '${(_resultat.fahrtzeit ?? 0) ~/ 3600} Stunden, ${((_resultat.fahrtzeit ?? 0) % 3600) ~/ 60} Minuten'
                  //_resultat.fahrtkostenZeit.toString(),
                  ),
              _buildHeader('Angaben zu den Kosten'),
              _buildCard(
                'Fahrtkosten (Strecke)',
                '${_resultat.fahrtkostenStrecke ~/ 100},${(_resultat.fahrtkostenStrecke % 100) ~/ 10}${_resultat.fahrtkostenStrecke % 10} €',
                '+',
              ),
              _buildCard(
                'Fahrtkosten (Zeit)',
                '${_resultat.fahrtkostenZeit ~/ 100},${(_resultat.fahrtkostenZeit % 100) ~/ 10}${_resultat.fahrtkostenZeit % 10} €',
                '+',
              ),
              _buildCard(
                'Hotelkosten',
                '${_resultat.hotelkosten ~/ 100},${(_resultat.hotelkosten % 100) ~/ 10}${_resultat.hotelkosten % 10} €',
                '+',
              ),
              _buildDivider(1),
              _buildCard(
                'Summe',
                '${_resultat.summe ~/ 100},${(_resultat.summe % 100) ~/ 10}${_resultat.summe % 10} €',
                '=',
              ),
              _buildCard(
                'Mehrwertsteuer',
                '${_resultat.mwst ~/ 100},${(_resultat.mwst % 100) ~/ 10}${_resultat.mwst % 10} €',
                '+',
              ),
              _buildDivider(2),
              _buildCard(
                'Bruttosumme',
                '${_resultat.bruttosumme ~/ 100},${(_resultat.bruttosumme % 100) ~/ 10}${_resultat.bruttosumme % 10} €',
                '=',
              ),
            ]),
      );

  SingleChildScrollView _buildBodyLandscape(Resultat _resultat) =>
      SingleChildScrollView(
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader('Angaben zur Strecke'),
                  _buildCard(
                    'km',
                    _resultat.fahrtstrecke.toString(),
                  ),
                  _buildCard('Zeit',
                      '${_resultat.fahrtzeit ?? 0 ~/ 60} Stunden, ${_resultat.fahrtzeit ?? 0 % 60} Minuten'
                      //_resultat.fahrtkostenZeit.toString(),
                      ),
                ],
              ),
            ),
            Container(
              width: 20,
            ),
            Expanded(
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader('Angaben zu den Kosten'),
                  _buildCard(
                    'Fahrtkosten (Strecke)',
                    '${_resultat.fahrtkostenStrecke ~/ 100},${(_resultat.fahrtkostenStrecke % 100) ~/ 10}${_resultat.fahrtkostenStrecke % 10} €',
                    '+',
                  ),
                  _buildCard(
                    'Fahrtkosten (Zeit)',
                    '${_resultat.fahrtkostenZeit ~/ 100},${(_resultat.fahrtkostenZeit % 100) ~/ 10}${_resultat.fahrtkostenZeit % 10} €',
                    '+',
                  ),
                  _buildCard(
                    'Hotelkosten',
                    '${_resultat.hotelkosten ~/ 100},${(_resultat.hotelkosten % 100) ~/ 10}${_resultat.hotelkosten % 10} €',
                    '+',
                  ),
                  _buildDivider(1),
                  _buildCard(
                    'Summe',
                    '${_resultat.summe ~/ 100},${(_resultat.summe % 100) ~/ 10}${_resultat.summe % 10} €',
                    '=',
                  ),
                  _buildCard(
                    'Mehrwertsteuer',
                    '${_resultat.mwst ~/ 100},${(_resultat.mwst % 100) ~/ 10}${_resultat.mwst % 10} €',
                    '+',
                  ),
                  _buildDivider(2),
                  _buildCard(
                    'Bruttosumme',
                    '${_resultat.bruttosumme ~/ 100},${(_resultat.bruttosumme % 100) ~/ 10}${_resultat.bruttosumme % 10} €',
                    '=',
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Padding _buildHeader(String header) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Text(
          header,
          style: const TextStyle(
            fontSize: 24,
            decoration: TextDecoration.underline,
          ),
        ),
      );

  Padding _buildCard(String title, String value, [String? operator]) => Padding(
        padding: const EdgeInsets.all(8),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            if (operator != null) Text('$operator '),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: operator == null || operator != '='
                      ? FontWeight.normal
                      : FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(value,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: operator == null || operator != '='
                        ? FontWeight.normal
                        : FontWeight.bold,
                  )),
            ),
          ],
        ),
      );
  Card _buildDivider(double height) => Card(
        child: Container(
          width: double.infinity,
          height: height,
          color: Colors.black,
        ),
      );
}
