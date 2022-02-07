import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/utils/colors.dart';

class GetImageStorage extends StatefulWidget {
  String nameImage;

  GetImageStorage(this.nameImage);

  @override
  _GetImageStorageState createState() => _GetImageStorageState();
}

class _GetImageStorageState extends State<GetImageStorage> {

  Uint8List imageFile;
  StorageReference photoReference = storage.ref();

  getImage(){
    int MAX_SIZE = 4*1024*1024;

    photoReference.child(widget.nameImage).getData(MAX_SIZE).then((data){
      this.setState(() {
        imageFile = data;
      });
    }).catchError((err){
      print(err);
    });
  }

  Widget decideGridTileWidget(){
    if(imageFile == null){
      return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,));
    }else{
      return Image.memory(imageFile, fit: BoxFit.cover, color: orangeBackground,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return decideGridTileWidget();
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

}

class GetImageAvtStorage extends StatefulWidget {
  String nameImage;

  GetImageAvtStorage(this.nameImage);

  @override
  _GetImageAvtStorageState createState() => _GetImageAvtStorageState();
}

class _GetImageAvtStorageState extends State<GetImageAvtStorage> {

  Uint8List imageFile;
  StorageReference photoReference = storage.ref();

  getImage(){
    int MAX_SIZE = 4*1024*1024;

    photoReference.child(widget.nameImage).getData(MAX_SIZE).then((data){
      this.setState(() {
        imageFile = data;
      });
    }).catchError((err){
      print(err);
    });
  }

  Widget decideGridTileWidget(){
    if(imageFile == null){
      return Image.asset('assets/images/avatar.jpg', fit: BoxFit.fill,);
    }else{
      return Image.memory(imageFile, fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return decideGridTileWidget();
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

}
