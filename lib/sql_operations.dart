import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'photos.dart';

class DBHelper {
  static Database _db;
  static const String Id = 'controlnum';
  static const String MATRICULA = 'matricula';
  static const String NAME = 'name';
  static const String APEPATE = 'apepate';
  static const String APEMATE = 'apemate';
  static const String CORREO = 'correo';
  static const String TELEFONO = 'telefono';
  static const String PHOTO_NAME = 'photoName';
  static const String TABLE = 'Students';
  static const String DB_NAME = 'students01.db';

//Creación de la base de datos (Verificar existencias)
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    print(appDirectory);
    String path = join(appDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($Id INTEGER PRIMARY KEY,$MATRICULA TEXT, $NAME TEXT, $APEPATE TEXT, $APEMATE TEXT, $CORREO TEXT, $TELEFONO TEXT, $PHOTO_NAME TEXT)");
  }

  //EQUIVALENTE A SELECT LIKE
  Future<List<Student>>Busqueda(String buscado) async{
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE WHERE $MATRICULA LIKE '$buscado%'");
    List<Student> studentss = [];
    print(maps);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }
  //EQUIVALENTE A SELECT
  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [Id, MATRICULA,NAME,APEPATE,APEMATE,CORREO,TELEFONO, PHOTO_NAME]);
    List<Student> studentss = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }

  /*SELECT
  Future<List<Student>> getStudents(String matri) async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,columns: [Id,MATRICULA,NAME,APEPATE,APEMATE,CORREO,TELEFONO, PHOTO_NAME]);
    List<Student> studentss = [];
    if(matri==null){
      if(maps.length > 0) {
        for(int i = 0; i < maps.length; i++ ){
          studentss.add(Student.fromMap(maps[i]));
        }
      }}
    else{
      List<Map> maps= await dbClient.query(TABLE, columns: [Id,MATRICULA,NAME,APEPATE,APEMATE,CORREO,TELEFONO,PHOTO_NAME], where: '$MATRICULA LIKE?', whereArgs: [matri]);
      if (maps.length > 0){
        for (int i =0; i < maps.length; i++) {
          studentss.add(Student.fromMap(maps[i]));
        }
      }
    }
    return studentss;
  }*/

  //getMatricula
  Future<int> getMatricula (String matri) async{
    var dbClient = await db;
    List<Map> maps1 = await dbClient.query(TABLE,columns: [Id,MATRICULA], where: '$MATRICULA=?', whereArgs: [matri]);
    int col = maps1.length;
    return col;
  }

  //SAVE O INSERT
  Future<Student> insert(Student student) async {
    var dbClient = await db;
    student.controlnum = await dbClient.insert(TABLE, student.toMap());
    return student;
  }

  //DELETE
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$Id = ?', whereArgs: [id]);
  }

  //UPDATE
  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, student.toMap(),
        where: '$Id = ?', whereArgs: [student.controlnum]);
  }

  Future<int> studentssupdate(Studentupdate student) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, student.toMaps(),
        where: '$Id = ?', whereArgs: [student.controlnum]);
  }


  /*SAVE O INSERT
  Future<Photo> save(Photo photo) async {
    var dbClient = await db;
    photo.id = await dbClient.insert(TABLE, photo.toMap());
    return photo;
  }

  getMatricula
  Future<List<Photo>> getPhotos () async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,columns: [Idp,PHOTO_NAME]);
    List<Photo> photos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(Photo.fromMap(maps[i]));
      }
    }
    return photos;
  }*/

  Future closedb() async {
    var dbClient = await db;
    dbClient.close();
  }
}


