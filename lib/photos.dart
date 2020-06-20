import 'package:flutter/material.dart';

class Student{
  int controlnum;
  String matricula;
  String name;
  String apepate;
  String apemate;
  String correo;
  String telefono;
  String photoName;

  Student(this.controlnum, this.matricula, this.name, this.apepate, this.apemate, this.correo, this.telefono, this.photoName);

  Map<String,dynamic>toMap(){
    print("hola");
    print(matricula);
    var map = <String,dynamic>{
      'controlnum': controlnum,
      'matricula' : matricula,
      'name': name,
      'apepate' : apepate,
      'apemate' : apemate,
      'correo' : correo,
      'telefono' : telefono,
      'photoName':photoName,
    };
    return map;
  }

  Student.fromMap(Map<String,dynamic> map){
    controlnum = map['controlnum'];
    matricula = map['matricula'];
    name = map['name'];
    apepate = map['apepate'];
    apemate = map['apemate'];
    correo = map['correo'];
    telefono = map['telefono'];
    photoName = map['photoName'];
  }
}

class Studentupdate{
  int controlnum;
  String campo;
  String valor;

  Studentupdate (this.controlnum, this.campo, this.valor);
  Map<String,dynamic>toMaps(){
    print("esto recibi");
    print(controlnum);
    print(campo);
    print(valor);
    var map = <String,dynamic>{
      'controlnum': controlnum,
      '$campo' : valor,
    };
    return map;
  }
  Studentupdate.fromMap(Map<String,dynamic> map){
    controlnum = map['controlnum'];
    valor = map['$campo'];
  }
}

