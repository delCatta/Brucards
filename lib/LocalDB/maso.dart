import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


import 'carta.dart';

class Maso with ChangeNotifier {
  // notifyListeners() : Notifica a todo lo que se tenga que actualizar al cambiar this.
  int masos;
  List<Carta> maso = new List<Carta>();

  List<Carta> getMaso() {
    return maso;
  }

  void revolverMaso() {
    maso.shuffle();
    notifyListeners();
  }

  Carta sacarCarta({bool listen:true}) {
    // Elegir Random Carta del Maso.
    // Sacar Random Carta del Maso.
    // Retornar Random Carta.
    if (maso.length == 0) {
      print("No hay más cartas");
      return null;
    }
    Random random = new Random();
    Carta chosen = maso[random.nextInt(maso.length)];
    maso.remove(chosen);
    if(listen) notifyListeners();
    return chosen;
  }
  

  void addCards(int cantMasos) {
    // Añadir cantMasos masos a maso.
    List<Carta> unMaso = [
      new Carta("As", "Trébol", CupertinoColors.black),
      new Carta("2", "Trébol", CupertinoColors.black),
      new Carta("3", "Trébol", CupertinoColors.black),
      new Carta("4", "Trébol", CupertinoColors.black),
      new Carta("5", "Trébol", CupertinoColors.black),
      new Carta("6", "Trébol", CupertinoColors.black),
      new Carta("7", "Trébol", CupertinoColors.black),
      new Carta("8", "Trébol", CupertinoColors.black),
      new Carta("9", "Trébol", CupertinoColors.black),
      new Carta("10", "Trébol", CupertinoColors.black),
      new Carta("J", "Trébol", CupertinoColors.black),
      new Carta("Qüina", "Trébol", CupertinoColors.black),
      new Carta("Rey", "Trébol", CupertinoColors.black),
      new Carta("As", "Pica", CupertinoColors.black),
      new Carta("2", "Pica", CupertinoColors.black),
      new Carta("3", "Pica", CupertinoColors.black),
      new Carta("4", "Pica", CupertinoColors.black),
      new Carta("5", "Pica", CupertinoColors.black),
      new Carta("6", "Pica", CupertinoColors.black),
      new Carta("7", "Pica", CupertinoColors.black),
      new Carta("8", "Pica", CupertinoColors.black),
      new Carta("9", "Pica", CupertinoColors.black),
      new Carta("10", "Pica", CupertinoColors.black),
      new Carta("J", "Pica", CupertinoColors.black),
      new Carta("Qüina", "Pica", CupertinoColors.black),
      new Carta("Rey", "Pica", CupertinoColors.black),
      new Carta("As", "Diamante", CupertinoColors.destructiveRed),
      new Carta("2", "Diamante", CupertinoColors.destructiveRed),
      new Carta("3", "Diamante", CupertinoColors.destructiveRed),
      new Carta("4", "Diamante", CupertinoColors.destructiveRed),
      new Carta("5", "Diamante", CupertinoColors.destructiveRed),
      new Carta("6", "Diamante", CupertinoColors.destructiveRed),
      new Carta("7", "Diamante", CupertinoColors.destructiveRed),
      new Carta("8", "Diamante", CupertinoColors.destructiveRed),
      new Carta("9", "Diamante", CupertinoColors.destructiveRed),
      new Carta("10", "Diamante", CupertinoColors.destructiveRed),
      new Carta("J", "Diamante", CupertinoColors.destructiveRed),
      new Carta("Qüina", "Diamante", CupertinoColors.destructiveRed),
      new Carta("Rey", "Diamante", CupertinoColors.destructiveRed),
      new Carta("As", "Corazón", CupertinoColors.destructiveRed),
      new Carta("2", "Corazón", CupertinoColors.destructiveRed),
      new Carta("3", "Corazón", CupertinoColors.destructiveRed),
      new Carta("4", "Corazón", CupertinoColors.destructiveRed),
      new Carta("5", "Corazón", CupertinoColors.destructiveRed),
      new Carta("6", "Corazón", CupertinoColors.destructiveRed),
      new Carta("7", "Corazón", CupertinoColors.destructiveRed),
      new Carta("8", "Corazón", CupertinoColors.destructiveRed),
      new Carta("9", "Corazón", CupertinoColors.destructiveRed),
      new Carta("10", "Corazón", CupertinoColors.destructiveRed),
      new Carta("J", "Corazón", CupertinoColors.destructiveRed),
      new Carta("Qüina", "Corazón", CupertinoColors.destructiveRed),
      new Carta("Rey", "Corazón", CupertinoColors.destructiveRed),
    ];
    for (var i = 0; i < cantMasos; i++) {
      maso.addAll(unMaso);
    }
    revolverMaso();
  }

  void printMaso() {
    for (Carta carta in maso) {
      print(carta.toString());
    }
  }

  Maso(int m) {
    masos = m;
    addCards(m);
  }
}
