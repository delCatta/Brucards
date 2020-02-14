import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../LocalDB/carta.dart';
import '../LocalDB/mano.dart';
import '../LocalDB/maso.dart';
import '../LocalDB/mesa.dart';
import 'tablero.dart';

class RelojInicio extends StatefulWidget {
  @override
  _RelojInicioState createState() => _RelojInicioState();
}

class _RelojInicioState extends State<RelojInicio> {
  int maxMano;
  int cantMasos;
  @override
  initState() {
    super.initState();
    cantMasos = 1;
    maxMano = 3;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      appBar: AppBar(
        title: Text("Inicio Reloj"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Cantidad de Masos:",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      index = index + 1;
                      return Container(
                        width: 50,
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              cantMasos = index;
                            });
                          },
                          child: Card(
                            color: Colors.transparent,
                            elevation: 10.0,
                            child: Text(
                              "${index == cantMasos ? "Seleccionado." : ""} $index",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Text(
                "Cartas en Mano:",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      index = index + 1;
                      return Container(
                        width: 50,
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              maxMano = index;
                            });
                          },
                          child: Card(
                            color: Colors.black,
                            elevation: 10.0,
                            child: Text(
                              "${index == maxMano ? "Seleccionado. " : ""} $index",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
          MaterialButton(
            child: Text(
              "Comenzar Reloj",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => CreateMaso(cantMasos, maxMano)));
            },
          ),
        ],
      ),
    );
  }
}

class CreateMaso extends StatefulWidget {
  const CreateMaso(this.cMaso, this.cMano);
  final int cMaso;
  final int cMano;
  @override
  _CreateMasoState createState() => _CreateMasoState();
}

class _CreateMasoState extends State<CreateMaso> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VisibleMesa(),
        ),
        ChangeNotifierProvider(
          create: (context) => MesaTotal(),
        ),
        ChangeNotifierProvider(
          create: (context) => Maso(widget.cMaso),
        ),
        ChangeNotifierProvider(
          create: (context) => Mano(widget.cMano, context),
        ),
      ],
      child: Reloj(),
    );
  }
}

class Reloj extends StatefulWidget {
  @override
  _RelojState createState() => _RelojState();
}

class _RelojState extends State<Reloj> {
  bool rellenoAuto;
  bool showing;
  @override
  void initState() {
    rellenoAuto = true;
    showing = false;
    super.initState();
  }

  void changeShowing() {
    setState(() {
      showing = !showing;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showing) return Tablero(notifyParent: changeShowing);
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      appBar: AppBar(title: Text("Reloj"), actions: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              null,
              semanticLabel:
                  "Relleno automático ${rellenoAuto ? "activado" : "desactivado"}",
            ),
            Switch(
              value: rellenoAuto,
              onChanged: (bool b) {
                setState(() {
                  rellenoAuto = b;
                });
              },
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: CupertinoColors.white,
            semanticLabel: "Reiniciar Tablero Actual",
          ),
          onPressed: () {
            MesaTotal mesa = Provider.of<MesaTotal>(context, listen: false);
            VisibleMesa visible =
                Provider.of<VisibleMesa>(context, listen: false);
            mesa.addElementsOf(visible.getMesa());
            visible.deleteElements();
          },
        ),
      ]),
      body: Consumer<Maso>(builder: (context, maso, _) {
        return Consumer<Mano>(builder: (context, mano, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Quedan ${maso.getMaso().length} Cartas en el Maso."),
              !rellenoAuto &&
                      mano.getMano().length < mano.getCapacidad() &&
                      maso.getMaso().length > 0
                  ? MaterialButton(
                      child: Text("Sacar Carta"),
                      onPressed: () {
                        mano.addCard(maso.sacarCarta());
                      },
                    )
                  : Container(),
              new Expanded(
                child: ListView.builder(
                  itemCount: mano.getMano().length,
                  itemBuilder: (BuildContext context, int index) {
                    Carta carta = mano.getMano()[index];
                    return Card(
                      elevation: 10.0,
                      child: ListTile(
                        title: Text(carta.toString(),
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          if (mano.getMano().length >= 0) {
                            mano.tirarCarta(
                                carta,
                                false,
                                Provider.of<VisibleMesa>(context,
                                    listen: false));
                            if (rellenoAuto) {
                              mano.rellenarMano();
                            }
                            changeShowing();
                          }
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          );
        });
      }),
    );
  }
}
