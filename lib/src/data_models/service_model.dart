import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel{
  final String idService;
  final String nameService;
  final String imageService;
  final String page;

  ServiceModel({this.idService, this.nameService, this.imageService, this.page});

  factory ServiceModel.fromJson(String id, DocumentSnapshot snapshot){
    return ServiceModel(
      idService: id,
      nameService: snapshot['nameservice'],
      imageService: snapshot['imageservice'],
      page: snapshot['screenservice'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "nameService" : nameService,
      "imageService" : imageService,
    };
  }
  static ServiceModel s1() => ServiceModel(nameService: "Dọn dẹp nhà", imageService: 'assets/images/icon1.png', idService: 'DV01', page: '/service1');
  static ServiceModel s2() => ServiceModel(nameService: "Tổng vệ sinh", imageService: 'assets/images/icon6.png', idService: 'DV02', page: '/service2');
  static ServiceModel s3() => ServiceModel(nameService: "Nấu ăn gia đình", imageService: 'assets/images/icon7.png', idService: 'DV3', page: '/service3');

}