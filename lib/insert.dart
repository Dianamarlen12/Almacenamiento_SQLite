import 'package:flutter/material.dart';
import 'sql_operations.dart';
import 'photos.dart';
import 'convertidor.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class insert extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<insert> {
  //VARIABLES REFERENTES AL MANEJO DE LA BD
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Student>> Studentss;

  //CONTROLLERS
  TextEditingController controllermatricula = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controllerapepate = TextEditingController();
  TextEditingController controllerapemate = TextEditingController();
  TextEditingController controllercorreo = TextEditingController();
  TextEditingController controllertelefono = TextEditingController();
  TextEditingController controllerphoto = TextEditingController();
  String matricula = null;
  String name;
  String apepate;
  String apemate;
  String correo;
  String telefono;
  String ImagenString;
  int currentUserId;
  int count;

  var bdHelper;
  bool isUpdating; //PARA SABER ESTADO ACTUAL DE LA CONSULTA

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

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

  void verificar() async {
    print("bandera1");
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      print("bandera2");
      if (isUpdating) {
        Student stu = Student(
            currentUserId, name, matricula,apepate,apemate,correo,telefono,ImagenString);
        bdHelper.update(stu);
        setState(() {
          isUpdating = false;
        });
      } else {
        print("bandera3");
        print(name);
        print(matricula);
        Student stu =
        Student(null, matricula,name,apepate,apemate,correo,telefono,ImagenString);
        var col = await bdHelper.getMatricula(matricula);
        print(col);
        if (col == 0) {
          print("bandera4");
          bdHelper.insert(stu);
          print("listo");
          showInSnackBar(context,"Data saved");
        } else {
          print("erorr");
          showInSnackBar(context,"Error! Ya existe esta matricula");
        }
      }
      print("bandera5");
      cleanData();
      refreshList();
    }
  }

  final formkey = new GlobalKey<FormState>();

  //FORMULARIO
  Widget form() {
    return Form(
      key: formkey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new SizedBox(height: 10.0),
            //TEXT FIELD PARA DATOS DEL FORMULARIO
            TextFormField(
              controller: controllermatricula,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Matricula"),
              validator: (val) => val.length == 0 ? 'Ingresa nombre' : null,
              onSaved: (val) => matricula = val.toUpperCase(),
            ),
            new SizedBox(height: 10.0),
            TextFormField(
              controller: controllername,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Nombre"),
              validator: (val) => val.length == 0 ? 'Inténtelo de nuevo' : null,
              onSaved: (val) => name = val.toUpperCase(),
            ),
            new SizedBox(height: 10.0),
            TextFormField(
              controller: controllerapepate,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Apellido Paterno"),
              validator: (val) => val.length == 0 ? 'Inténtelo de nuevo' : null,
              onSaved: (val) =>apepate = val.toUpperCase(),
            ),
            new SizedBox(height: 10.0),
            TextFormField(
              controller: controllerapemate,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Apellido Materno"),
              validator: (val) => val.length == 0 ? 'Inténtelo de nuevo' : null,
              onSaved: (val) => apemate = val.toUpperCase(),
            ),
            new SizedBox(height: 10.0),
            TextFormField(
              controller: controllercorreo,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "E-mail"),
              validator: (val) => !val.contains('@') ? 'Correo incorrecto' : null,
              onSaved: (val) => correo = val,
            ),
            new SizedBox(height: 10.0),
            TextFormField(
              controller: controllertelefono,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Telefono"),
              validator: (val) => val.contains('numeros') ? 'Ingrese numeros' : null,
              onSaved: (val) => telefono = val.toUpperCase(),
            ),
            TextFormField(
              controller: controllerphoto,
              decoration: InputDecoration(labelText: "Imagen Estudiante", suffixIcon: IconButton(
                  icon: Icon(Icons.add_circle), onPressed: _optionsDialogBox)),
              validator: (val) => val.length == 0 ? "Ingresa Imagen" : val.length > 0 ?
              controllerphoto.text == "Archivo Imagen Estudiante" ? null : "Solo permite imagenes" : null,
            ),
            SizedBox(height: 30),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                  onPressed: () async {
                    verificar();
                  },
                  //SI ESTA LLENO ACTUALIZAR, SI NO AGREGAR
                  child: Text(isUpdating ? 'Update' : 'Añadir'),
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
                  },
                  child: Text("Cancelar"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  pickImagefromGallery(){
    ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640).then((imgFile){
      String  imgString = Convertir.base64String(imgFile.readAsBytesSync());
       ImagenString = imgString;
       controllerphoto.text = "Archivo Imagen Estudiante";
       return ImagenString;
    });
  }

  pickImagefromPhoto(){
    ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640).then((imgFile){
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
                padding: EdgeInsets.all(12.0),),
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

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text('INSERTAR DATOS'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            form(),
            //list(),
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
              fontSize: 20.0,
              fontFamily: 'Schyler',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}