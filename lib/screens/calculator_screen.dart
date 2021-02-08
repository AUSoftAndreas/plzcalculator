import 'package:flutter/material.dart';
import 'package:plzcalculator/functions/functions.dart';
import 'package:plzcalculator/models/eingabe.dart';
import 'package:plzcalculator/models/resultat.dart';
import 'package:plzcalculator/providers/map_provider_interface.dart';
import 'package:plzcalculator/screens/resultat_screen.dart';
import 'package:plzcalculator/screens/settings_screen.dart';

class CalculatorScreen extends StatefulWidget {
  static String routeName = '/';
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _eingabe = '';

  @override
  Widget build(BuildContext context) {
    // Wir berechnen das Layout
    // Portrait-Modus
    double calcHeight;
    double padX;
    double padY;
    double resX;
    double resY;
    double buttSize;
    final screenPadding = MediaQuery.of(context).padding;
    const double stdPadding = 10;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      calcHeight = 80;
      resY = MediaQuery.of(context).size.height - screenPadding.top - screenPadding.bottom - kToolbarHeight - calcHeight;
      //resY = 10 * stdPadding + 4 * buttSize;
      double buttSizeY = (resY - 11 * stdPadding) / 4;
      resX = MediaQuery.of(context).size.width - screenPadding.left - screenPadding.right;
      //resX = 6 * stdPadding + 3 * buttSizeX
      double buttSizeX = (resX - 6 * stdPadding) / 3;
      padX = stdPadding;
      padY = stdPadding;
      if (buttSizeX > buttSizeY) {
        buttSize = buttSizeY;
        padX = (resX - 3 * buttSize) / 6;
      } else {
        buttSize = buttSizeX;
        padY = (resY - 4 * buttSize) / 11;
      }
      resY = resY - 3 * padY;
    } else {
      // LANDSCAPE
      calcHeight = 80;
      resY = MediaQuery.of(context).size.height - screenPadding.top - screenPadding.bottom - kToolbarHeight - calcHeight;
      double buttSizeY = (resY - 6 * stdPadding) / 2;
      resX = MediaQuery.of(context).size.width - screenPadding.left - screenPadding.right;
      double buttSizeX = (resX - 12 * stdPadding) / 6;
      padX = stdPadding;
      padY = stdPadding;
      if (buttSizeX > buttSizeY) {
        buttSize = buttSizeY;
        padX = (resX - 6 * buttSize) / 12;
      } else {
        buttSize = buttSizeX;
        padY = (resY - 2 * buttSize) / 6;
      }
      resY = resY - 3 * padY;
    }
    // Wir haben die maximale Größe herausgefunden

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PLZ-Calculator',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              padX,
              padY,
              padX,
              2 * padY,
            ),
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: calcHeight.toDouble(),
              child: Center(
                child: Text(
                  _eingabe,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 48,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padX),
            child: Container(
              height: resY,
              width: resX,
              child: GridView.count(
                crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 3 : 6,
                crossAxisSpacing: 2 * padX,
                mainAxisSpacing: 2 * padY,
                children: _buildKeys(MediaQuery.of(context).orientation),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildKeys(Orientation orientation) {
    List<Widget> list = [];
    for (int x = 1; x <= 12; x++) {
      if (x < 10) {
        list.add(
          Card(
            color: Colors.grey[350],
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                pressButton(x.toString());
              },
              child: Center(
                child: Text(
                  x.toString(),
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if ((x == 10 && orientation == Orientation.portrait) || (x == 11 && orientation == Orientation.landscape)) {
        list.add(
          Card(
            color: Colors.grey[350],
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                pressButton('DEL');
              },
              child: Center(
                child: Text(
                  '<-',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if ((x == 11 && orientation == Orientation.portrait) || (x == 10 && orientation == Orientation.landscape)) {
        list.add(
          Card(
            color: Colors.grey[350],
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                pressButton('0');
              },
              child: Center(
                child: Text(
                  '0',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        list.add(
          Card(
            color: Colors.grey[350],
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                pressButton('OK');
              },
              child: Center(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    return list;
  }

  void pressButton(String key) async {
    if (key == 'DEL') {
      if (_eingabe.length > 0) {
        setState(() {
          _eingabe = _eingabe.substring(0, _eingabe.length - 1);
        });
      }
    } else if (key == 'OK') {
      if (_eingabe != null && _eingabe.length == 5 && Funktionen.isNumeric(_eingabe)) {
        MapProvider mp = MapProvider();
        Resultat resultat = await mp.getResult(Eingabe(_eingabe));
        if (resultat != null) {
          Navigator.pushNamed(context, ResultatScreen.routeName, arguments: resultat);
        }
      }
    } else {
      if (_eingabe.length < 5) {
        setState(() {
          _eingabe = '$_eingabe$key';
        });
      }
    }
    // log('Eingabe danach: $_eingabe');
  }
}
