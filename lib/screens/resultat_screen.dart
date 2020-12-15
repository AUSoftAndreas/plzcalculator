import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plzcalculator/models/resultat.dart';

class ResultatScreen extends StatelessWidget {
  static String routeName = '/resultat';
  Resultat _resultat;

  ResultatScreen(Resultat resultat) {
    _resultat = resultat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultat'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ],
      ),
      body: Flex(direction: Axis.vertical, children: [
        Text('km: ${_resultat.fahrtstrecke}'),
        Text('Zeit: ${_resultat.fahrtzeit}'),
        Text('FkStrecke: ${_resultat.fahrtkostenStrecke}'),
        Text('fahrtkostenZeit: ${_resultat.fahrtkostenZeit}'),
        Text('hotelkosten: ${_resultat.hotelkosten}'),
        Text('summe: ${_resultat.summe}'),
        Text('mwst: ${_resultat.mwst}'),
        Text('bruttosumme: ${_resultat.bruttosumme}'),
      ]),
    );
  }
}