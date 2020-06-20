import 'sql_operations.dart';
import 'photos.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'convertidor.dart';
import 'card.dart';

class Consultar extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<Consultar> {
  //ELEMENTO PARA BUSQUEDA
  String searchString = "";
  bool _isSearching = false;

  Future<List<Student>> Studentss;
  var dbHelper;
  TextEditingController controller_busqueda = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _isSearching = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = dbHelper.Busqueda(controller_busqueda.text);
    });
  }

  void cleanData() {
    controller_busqueda.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: _isSearching
            ? TextField(
                decoration: InputDecoration(hintText: "Buscando..."),
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                controller: controller_busqueda,
              )
            : Text(
                "CONSULTAR REGISTROS",
                style: TextStyle(color: Colors.white),
              ),
        actions: <Widget>[
          !_isSearching
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      searchString = "";
                      this._isSearching = !this._isSearching;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      this._isSearching = !this._isSearching;
                    });
                  },
                )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: FutureBuilder(
            future: Studentss,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Cargando..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index].matricula
                            .contains(controller_busqueda.text)
                        ? ListTile(
                            leading: CircleAvatar(
                              minRadius: 30.0,
                              maxRadius: 30.0,
                              backgroundColor: Colors.white,
                              backgroundImage: Convertir.imageFromBase64String(
                                      snapshot.data[index].photoName)
                                  .image,
                            ),
                            title: new Text(
                              snapshot.data[index].matricula
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: new Text(
                              snapshot.data[index].name
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          Informacion(snapshot.data[index])));
                            },
                          )
                        : Container();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
