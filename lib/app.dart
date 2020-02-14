import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Juegos/reloj.dart';

class BrucardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            primaryColor: Colors.blue,
            backgroundColor: Colors.black,
            accentColor: Colors.grey,
            scaffoldBackgroundColor: Colors.black),
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LocalInit(),
            ],
          ),
        ));
  }
}

class LocalInit extends StatefulWidget {
  @override
  _LocalInitState createState() => _LocalInitState();
}

class _LocalInitState extends State<LocalInit> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text("Brucards",style: TextStyle(color: Colors.blue),),
      onPressed: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeleccionarJuego()));
      },
    );
  }
}

class SeleccionarJuego extends StatefulWidget {
  @override
  _SeleccionarJuegoState createState() => _SeleccionarJuegoState();
}

class _SeleccionarJuegoState extends State<SeleccionarJuego> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Seleccionar Juego"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                child: Text("Iniciar reloj",style:TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RelojInicio()));
                }),
          ],
        ),
      ),
    );
  }
}
