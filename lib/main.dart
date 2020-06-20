import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'sql_operations.dart';
import 'photos.dart';
import 'dart:async';
import 'insert.dart';
import 'delete.dart';
import 'update.dart';
import 'select.dart';
import 'search.dart';
import 'consultar.dart';
import 'convertidor.dart';
import 'card.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Database',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {
  //Variables referentes al manejo de la BD
  final _scafoldkey = GlobalKey<ScaffoldState>();
  var bdHelper;


  Future<List<Student>> Studentss;
  TextEditingController controllermatricula = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controllerapepate = TextEditingController();
  TextEditingController controllerapemate = TextEditingController();
  TextEditingController controllercorreo = TextEditingController();
  TextEditingController controllertelefono = TextEditingController();
  TextEditingController controllerphoto = TextEditingController();
  String matricula;
  String name;
  String apepate;
  String apemate;
  String correo;
  String telefono;
  int currentUserId;
  String ImagenString;
  int opcion;
  String campo;
  //

  String descriptive_text = "Student Name";

  final formkey = new GlobalKey<FormState>();
  //var bdHelper;

  //Estado actual de la consulta
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  //select
  void refreshList() {
    setState(() {
      Studentss = bdHelper.getStudents();
    });
  }

  void cleanData() {
    controllermatricula.text = "";
    controllername.text = "";
    controllerapepate.text = "";
    controllerapemate.text = "";
    controllertelefono.text = "";
    controllercorreo.text = "";
    controllerphoto.text = "";
  }


  /*void insertData() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      {
        Student stu = Student(null, matricula, name, apepate, apemate, telefono, correo, ImagenString);
        bdHelper.insert(stu);
      }
      cleanData();
      refreshList();
    }
  }*/
  //Formulario

  /*Widget form() {
    return Form(
      key: formkey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new SizedBox(height: 50.0),
            TextFormField(
              controller: opcion==1?controllermatricula:
              opcion==2?controllername:
              opcion==3?controllerapepate:
              opcion==4?controllerapemate:
              opcion==5?controllercorreo:
              opcion==5?controllertelefono:
              controllerphoto,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: descriptive_text),
              validator: (val) => val.length == 0 ? 'Enter Data' : null,
              onSaved: (val) => val = val,
            ),

            SizedBox(height: 30,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                  onPressed: insertData,
                  //child: Text(isUpdating ? 'Update ' : 'Add Data'),
                  child: Text('Update Data'),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    cleanData();
                    refreshList();
                  },
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }*/

  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("Matricula"),
            ),
            DataColumn(
              label: Text("Nombre"),
            ),
            DataColumn(
              label: Text("Apellido Paterno"),
            ),
            DataColumn(
              label: Text("Apellido Materno"),
            ),
            DataColumn(
              label: Text("Correo"),
            ),
            DataColumn(
              label: Text("Telefono"),
            ),
            DataColumn(
              label: Text("Foto"),
            ),
          ],
          rows: Studentss.map((student) => DataRow(cells: [
            DataCell(Text(student.matricula.toString().toUpperCase())),
            DataCell(Text(student.name.toString().toUpperCase())),
            DataCell(Text(student.apepate.toString().toUpperCase())),
            DataCell(Text(student.apemate.toString().toUpperCase())),
            DataCell(Text(student.correo.toString().toUpperCase())),
            DataCell(Text(student.telefono.toString().toUpperCase())),
            DataCell(Convertir.imageFromBase64String(student.photoName)),
          ])).toList(),
        ),
      ),);
  }


  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No data founded!");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scafoldkey,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'OPERACIONES SQL',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,),),),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Container(
                width: 350,
                height: 350,
                child: Image.network(
                    'https://2.bp.blogspot.com/-93Mt1QRv6Bo/V8G22oUacrI/AAAAAAAAC5k/Id7DOEm558QOBR4kizycJ1iH1yaDp_gCgCLcB/s1600/sqlite.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Text("BASE DE DATOS", textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],),
      //MENU LATERAL
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("OPERACIONES SQL",
                  style: TextStyle(
                      fontFamily: 'Carter', fontSize: 30, color: Colors.white)),
              decoration: BoxDecoration(color: Colors.black),
            ),
            ListTile(
              title: Text("INSERTAR",
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new insert()
                    ));
              },),
            ListTile(
              title: Text(
                "ACTUALIZAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new update()
                    ));
              },),
            ListTile(
              title: Text(
                "BORRAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new delete()
                    ));
              },),
            ListTile(
              title: Text(
                "BUSCAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new search()
                    ));
              },),
            ListTile(
              title: Text(
                "SELECCIONAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new select()
                    ));
              },),
            ListTile(
              title: Text(
                "CONSULTAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Consultar()
                    ));
              },),
          ],
        ),
      ),
    );
  }
}
