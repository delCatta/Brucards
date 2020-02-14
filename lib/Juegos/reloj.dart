import 'package:brucards/Juegos/tablero.dart';
import 'package:brucards/LocalDB/carta.dart';
import 'package:brucards/LocalDB/mano.dart';
import 'package:brucards/LocalDB/maso.dart';
import 'package:brucards/LocalDB/mesa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelojInicio extends StatefulWidget {
  @override
  _RelojInicioState createState() => _RelojInicioState();
}

class _RelojInicioState extends State<RelojInicio> {
  double maxMano;
  double cantMasos;
  @override
  initState() {
    super.initState();
    maxMano = 1.0;
    cantMasos = 1.0;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      appBar: AppBar(
        title: Text("Inicio Reloj"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Cantidad de Masos"),
            onChanged: (String c) {
              if (c != "") {
                setState(() {
                  cantMasos = double.parse(c);
                });
              }
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Cantidad de Cartas en Mano"),
            onChanged: (String c) {
              if (c != "") {
                setState(() {
                  maxMano = double.parse(c);
                });
              }
            },
          ),
          MaterialButton(
            child: Text("Comenzar Reloj"),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          CreateMaso(cantMasos.toInt(), maxMano.toInt())));
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
        )
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
