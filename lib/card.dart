import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'convertidor.dart';
import 'photos.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Informacion extends StatelessWidget {
  final Student student;

  Informacion(this.student);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("ABOUT ME"),
      ),
      body: Container(
        //color: Colors.lightBlueAccent[100],
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 750,
              width: 450,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.deepPurple[900], Colors.blue[500]],
              )),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 95,
                        backgroundImage:
                            Convertir.imageFromBase64String(student.photoName)
                                .image,
                      ),
                    ),
                    //Text(""),
                    //Text(""),
                    Text(student.name.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          student.apepate.toString(),
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          student.apemate.toString(),
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "-------------------------",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Padding(padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 40,
                        width: 400,
                        color: Colors.white,
                        child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          IconButton(icon: Icon(Icons.fiber_pin, size: 30, color: Colors.black), onPressed: null),
                          Expanded(
                            child: Container(margin: EdgeInsets.only(right: 25.0, left: 25.0),
                              child: Text(
                                student.matricula.toString(),
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          )
                        ],
                        ),
                      ),
                      ),
                    Padding(padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 40,
                        width: 400,
                        color: Colors.white,
                        child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.phone_in_talk, size: 30, color: Colors.black), onPressed: null),
                            Expanded(
                              child: Container(margin: EdgeInsets.only(right: 25.0, left: 25.0),
                                child: Text(
                                  student.telefono.toString(),
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 40,
                        width: 400,
                        color: Colors.white,
                        child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.email, size: 30, color: Colors.black), onPressed: null),
                            Expanded(
                              child: Container(margin: EdgeInsets.only(right: 25.0, left: 25.0),
                                child: Text(
                                  student.correo.toString(),
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
