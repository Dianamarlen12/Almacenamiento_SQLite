import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'sql_operations.dart';
import 'convertidor.dart';
import 'photos.dart';

/*class StoreImageOnDatabaBase extends StatefulWidget {
  @override
  _StoreImageOnDatabaBaseState createState() => _StoreImageOnDatabaBaseState();
}

  class _StoreImageOnDatabaBaseState extends State<StoreImageOnDatabaBase> {
    //Variables Globales
    Future<File> imageFile;
    Image imagen;
    DBHelper dbHelper;
    List<Photo> imagenes;

    @override
    void initState(){
      super.initState();
      imagenes = [];
      dbHelper = DBHelper();
      refreshImage();
    }

    void refreshImage(){
      dbHelper.getPhotos().then((imgs){
        setState(() {
          imagenes.clear();
          imagenes.addAll(imgs);
        });
      });
}

    pickImagefromGallery(){
      ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile){
        String  imgString = Convertir.base64String(imgFile.readAsBytesSync());
        Photo photo = Photo(null,imgString);
        dbHelper.save(photo);
        refreshImage();
      });
    }

    Widget gridView(){
      return Padding(
        padding: EdgeInsets.all(5.0),
        child: GridView.count(crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children:
          imagenes.map((photo){
            return Convertir.imageFromBase64String(photo.photoName);
          }).toList(),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: new AppBar(
          title: new Text("Store Images on database"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add),
            onPressed: (){
              pickImagefromGallery();
            },)
          ],
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            )
          ],),
        ),
      );
    }
  }*/
