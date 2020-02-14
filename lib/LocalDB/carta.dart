import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mesa.dart';

class Carta {
  String numero;
  String pinta;
  Color color;
  int position=0;
  IconData icono;
  Carta(String n, String p, Color c) {
    numero = n;
    pinta = p;
    color = c;
  }
  @override
  String toString() {
    return this.numero + " de " + this.pinta + ".";
  }

  Widget widget(VisibleMesa tablero,BuildContext context) {
    return Positioned(
      top: 100+MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height+(position*2)),
      child: Card(
        elevation: 1.0,
        color: CupertinoColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color,)
        ),
        child: Container(
            width: 250,
            height: 350,
            child: Container(
              width: 245,
              height: 245,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      this.numero,
                      style: TextStyle(fontSize: 30,color: color),
                    ),
                    Icon(icono??null)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
