import 'package:flutter/material.dart';
import 'sql_operations.dart';
import 'photos.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'convertidor.dart';

class update extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<update> {
  //Variable referentes al manejo de la BD

  Future<List<Student>> Studentss;
  TextEditingController controllermatricula = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controllerapepate = TextEditingController();
  TextEditingController controllerapemate = TextEditingController();
  TextEditingController controllercorreo = TextEditingController();
  TextEditingController controllertelefono = TextEditingController();
  TextEditingController controllerphoto = TextEditingController();
  String matricula;
  bool imagen;
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
  var bdHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    imagen= false;
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

  /* void dataValidate() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (isUpdating) {
        Student stu = Student(currentUserId, name);
        dbHelper.update(stu);
        setState(() {
          isUpdating = false;
        });
      } else {
        Student stu = Student(null, name);
        dbHelper.insert(stu);
      }
      cleanData();
      refreshList();
    }
  }*/


  //Student e = Student(curUserId, name);

  void updateData() async{
    print("Valor de Opción");
    print(opcion);
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (opcion==1) {
        campo="matricula";
        var col = await bdHelper.getMatricula(controllermatricula.text);
        print(col);
        if (col == 0) {
          print("bandera4");
          Studentupdate stu = Studentupdate(currentUserId,campo,controllermatricula.text);
          bdHelper.studentssupdate(stu);
          print("listo");
          showInSnackBar(context,"Data saved");
        } else {
          print("erorr");
          showInSnackBar(context,"Error! Ya existe esta matricula");
        }

      }
      else if (opcion==2) {
        print(controllername.text);
        campo="name";
        Studentupdate stu = Studentupdate(currentUserId,campo,controllername.text.toUpperCase());
        bdHelper.studentssupdate(stu);
        print("listo00");
      }
      else if (opcion==3) {
        campo="apepate";
        Studentupdate stu = Studentupdate(currentUserId,campo,controllerapepate.text.toUpperCase());
        bdHelper.studentssupdate(stu);
      }
      else if (opcion==4) {
        campo="apemate";
        Studentupdate stu = Studentupdate(currentUserId,campo,controllerapemate.text.toUpperCase());
        bdHelper.studentssupdate(stu);
      }
      else if (opcion==5) {
        campo="correo";
        Studentupdate stu = Studentupdate(currentUserId,campo,controllercorreo.text);
        bdHelper.studentssupdate(stu);
      }
      else if (opcion==6) {
        campo="telefono";
        Studentupdate stu = Studentupdate(currentUserId,campo,controllertelefono.text);
        bdHelper.studentssupdate(stu);
      }
      else if (opcion==7) {
        print("act upd");
        campo="photoName";
        Studentupdate stu = Studentupdate(currentUserId,campo,ImagenString);
        bdHelper.studentssupdate(stu);
      }
      cleanData();
      refreshList();
    }
  }

  pickImagefromGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      ImagenString = imgString;
      controllerphoto.text = "Archivo Imagen Estudiante";
      return ImagenString;
    });
  }

  pickImagefromPhoto(){
    ImagePicker.pickImage(source: ImageSource.camera).then((imgFile){
      String  imgString = Convertir.base64String(imgFile.readAsBytesSync());
      ImagenString = imgString;
      controllerphoto.text = "Archivo Imagen Estudiante";
      return ImagenString;
    });
  }


  //Mandar a traer los metodos de galeria y de foto
  Future<void> _optionsDialogBox(){
    return showDialog(context: context,
        builder:(BuildContext context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Tomar foto"),
                    onTap: pickImagefromPhoto,),
                  Padding(
                    padding: EdgeInsets.all(8.0),),
                  GestureDetector(
                    child: Text("Subir una foto"),
                    onTap: pickImagefromGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }


  void insertData() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      {
        Student stu = Student(null, matricula, name, apepate, apemate, telefono, correo, ImagenString);
        bdHelper.insert(stu);
      }
      cleanData();
      refreshList();
    }
  }
  //Formulario

  Widget form() {
    return Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: new SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                new SizedBox(height: 50.0),
                TextFormField(
                  enabled: true,
                  controller: opcion==1?controllermatricula:
                  opcion==2?controllername:
                  opcion==3?controllerapepate:
                  opcion==4?controllerapemate:
                  opcion==5?controllercorreo:
                  opcion==6?controllertelefono:
                  controllerphoto,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: descriptive_text),
                  validator: (val) =>  val.length == 0 ?'Enter correctly' : opcion==7?val.length==0?"ingresa una foto":controllerphoto.text!="Archivo Imagen Estudiante"?"solo fotos":null:null,
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
                      onPressed: updateData,
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
        ));
  }

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
            DataCell(Text(student.matricula), onTap: () {
              setState(() {
                //isUpdating = true;
                descriptive_text = "Matricula";
                controllername.text = student.name;
                controllerapepate.text = student.apepate;
                controllerapemate.text = student.apemate;
                controllercorreo.text = student.correo;
                controllertelefono.text = student.telefono;
                controllermatricula.text = student.matricula;
                Convertir.imageFromBase64String(student.photoName);
                opcion=1;
                currentUserId = student.controlnum;
              });
              controllermatricula.text = student.matricula;
            }
            ),
            DataCell(Text(student.name), onTap: () {
              setState(() {
                //isUpdating = true;
                descriptive_text = "Nombre del estudiante";
                controllername.text = student.name;
                controllerapepate.text = student.apepate;
                controllerapemate.text = student.apemate;
                controllercorreo.text = student.correo;
                controllertelefono.text = student.telefono;
                controllermatricula.text = student.matricula;
                currentUserId = student.controlnum;
                Convertir.imageFromBase64String(student.photoName);
                opcion=2;
              });
              controllername.text = student.name;
            }),
            DataCell(Text(student.apepate),onTap: (){
              setState(() {
                //isUpdating = true;
                descriptive_text = "Apellido Paterno";
                controllername.text = student.name;
                controllerapepate.text = student.apepate;
                controllerapemate.text = student.apemate;
                controllercorreo.text = student.correo;
                controllertelefono.text = student.telefono;
                controllermatricula.text = student.matricula;
                currentUserId = student.controlnum;
                Convertir.imageFromBase64String(student.photoName);
                opcion=3;
              });
              controllerapepate.text = student.apepate;
            },),
            DataCell(Text(student.apemate),onTap: (){
              setState(() {
                //isUpdating = true;
                descriptive_text = "Apellido materno";
                controllername.text = student.name;
                controllerapepate.text = student.apepate;
                controllerapemate.text = student.apemate;
                controllercorreo.text = student.correo;
                controllertelefono.text = student.telefono;
                controllermatricula.text = student.matricula;
                currentUserId = student.controlnum;
                Convertir.imageFromBase64String(student.photoName);
                opcion=4;
              });
              controllerapemate.text = student.apemate;
            },),
            DataCell(Text(student.correo),onTap: (){
              setState(() {
                //isUpdating = true;
                descriptive_text = "Correo";
                controllername.text = student.name;
                controllerapepate.text = student.apepate;
                controllerapemate.text = student.apemate;
                controllercorreo.text = student.correo;
                controllertelefono.text = student.telefono;
                controllermatricula.text = student.matricula;
                currentUserId = student.controlnum;
                Convertir.imageFromBase64String(student.photoName);
                opcion=5;
              });
              controllercorreo.text = student.correo;
            },),
            DataCell(Text(student.telefono), onTap: (){
              setState(() {
                //isUpdating = true;
                descriptive_text = "Telefono";
                controllername.text = student.name;
                controllerapepate.text = student.apepate;
                controllerapemate.text = student.apemate;
                controllercorreo.text = student.correo;
                controllertelefono.text = student.telefono;
                controllermatricula.text = student.matricula;
                currentUserId = student.controlnum;
                Convertir.imageFromBase64String(student.photoName);
                opcion=6;
              });
              controllertelefono.text = student.telefono;
            },),
            DataCell(Convertir.imageFromBase64String(student.photoName),
              onTap: (){
                setState(() {
                  isUpdating = true;
                  descriptive_text = "Foto";
                  controllername.text = student.name;
                  controllerapepate.text = student.apepate;
                  controllerapemate.text = student.apemate;
                  controllercorreo.text = student.correo;
                  controllertelefono.text = student.telefono;
                  controllermatricula.text = student.matricula;
                  currentUserId = student.controlnum;
                  Convertir.imageFromBase64String(student.photoName);
                  opcion=7;
                });
                //controllertelefono.text = student.photoName;
                _optionsDialogBox();
              },),
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
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return new Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,   //new line
      appBar: new AppBar(
        title: Text('Actualizar Datos'),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }

  showInSnackBar(BuildContext context, String texto) {
    final snackBar = SnackBar(
        backgroundColor: Colors.black,
        content: new Text(texto,
            style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Schyler',
                fontWeight: FontWeight.bold,
                color: Colors.white
            )));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}
