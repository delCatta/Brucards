import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'carta.dart';
import 'maso.dart';
import 'mesa.dart';

class Mano with ChangeNotifier {
  int capacidad;
  bool rellenado;
  Maso maso;
  List<Carta> mano = new List<Carta>();
  
  List<Carta> getMano() {
    return mano;
  }
  
  void rellenarMano({bool listen:true}) {
    while (mano.length < capacidad && maso.getMaso().length>0) {
      this.addCard(maso.sacarCarta(listen:false));
    }
    rellenado = true;
    if(listen) notifyListeners();
  }
  
  Carta tirarCarta(Carta carta, bool bluetoothConnected,VisibleMesa mesa) {
    // Saca la Carta de la mano
    mano.remove(carta);
    // Tira la Carta a la Mesa Visible
    mesa.addCard(carta);
    notifyListeners();
    // if blueconnected: enviarCarta(device) al Host
  }
  
  void addCard(Carta carta) {
    mano.add(carta);
    notifyListeners();
  }
  
  int getCapacidad() {
    return capacidad;
  }
  
  Mano(int c, BuildContext context) {
    capacidad = c;
    rellenado = false;
    maso=Provider.of<Maso>(context,listen: false);
    rellenarMano(listen:false);
  }
}
