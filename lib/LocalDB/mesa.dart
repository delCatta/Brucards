import 'carta.dart';
import 'package:flutter/foundation.dart';

class MesaTotal with ChangeNotifier {
  List<Carta> mesa;
  List<Carta> lastMesa;
  MesaTotal() {
    mesa = new List<Carta>();
    lastMesa = new List<Carta>();
  }
  int getCant() {
    return mesa.length;
  }

  List<Carta> getMesa() {
    return mesa;
  }

  void addElementsOf(List<Carta> desde) {
    mesa.addAll(desde);
   notifyListeners();
  }

  void deleteElements() {
    lastMesa = mesa;
    mesa = new List<Carta>();
    notifyListeners();
  }

  void recoverLastMesa() {
    List<Carta> temp = mesa;
    mesa = lastMesa;
    lastMesa = temp;
    notifyListeners();
  }
}

class VisibleMesa with ChangeNotifier {
  List<Carta> mesa;
  List<Carta> lastMesa;
  int total=0;
  VisibleMesa() {
    mesa = new List<Carta>();
    lastMesa = new List<Carta>();
  }
  int getCant() {
    return mesa.length;
  }

  List<Carta> getMesa() {
    return mesa;
  }

  void addElementsOf(List<Carta> desde) {
    mesa.addAll(desde);
   notifyListeners();
  }
  void addCard(Carta c){
    mesa.add(c);
    c.position=total++;
    notifyListeners();
  }

  void deleteElements() {
    lastMesa = mesa;
    mesa = new List<Carta>();
    notifyListeners();
  }

  void recoverLastMesa() {
    List<Carta> temp = mesa;
    mesa = lastMesa;
    lastMesa = temp;
    notifyListeners();
  }
}
