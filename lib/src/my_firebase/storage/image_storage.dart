import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';

class ImageServiceStorage{

  static final StorageReference storageReference = storage.ref().child('imageservices');

  static Uint8List getImage(String image){
    int MAX_SIZE = 7*1024*1024;
    storageReference.child(image).getData(MAX_SIZE).then((data){
      return data;
    }).catchError((err){
      print(err);
      return null;
    });
  }

}