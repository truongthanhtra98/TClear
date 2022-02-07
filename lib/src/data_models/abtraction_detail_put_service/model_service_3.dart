import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/apartment_model.dart';
import 'package:sample_one/src/data_models/items_dropdownlist.dart';
import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/data_models/payment_method.dart';

class ModelService3 extends DetailPutService{
  int numberPersonEat;
  int numberFood;
  String taste;
  bool hasFruit;
  bool goMarket;

  ModelService3(){
    numberPersonEat = 2;
    numberFood = 2;
    taste = 'Bắc';
    hasFruit = true;
    goMarket = true;
    weightWork = Item(0, 2);
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapChild = {
      'id': 'DV03',
      'numberPersonEat': numberPersonEat,
      'numberFood': numberFood,
      'taste': taste,
      'hasFruit': hasFruit,
      'goMarket': goMarket,
      'weightWork':{
        'idItem': 0,
        'thoigianlam': 2,
        'songuoilam': 1,
      },
    };
    Map<String, dynamic> mapFinal = {};
    mapFinal.addAll(toMapAbstract());
    mapFinal.addAll(mapChild);
    return mapFinal;
  }

  @override
  double payment() {
    double total = 0;
    if(numberPersonEat < 4){
      total += 120;
    }else{
      total += 150;
    }
    if(numberFood > 3){
      total += 30;
    }

    return total*1000;
  }

  @override
  DetailPutService fromMap(AsyncSnapshot snapshot) {
    ModelService3 model = new ModelService3();
    model.idService = snapshot.data['id'];
    model.idDetail = snapshot.data.documentID;
    model.locationWork = new Location(formattedAddress: snapshot.data['location']['diachi'], lat: snapshot.data['location']['lat'], lng: snapshot.data['location']['lng']);
    model.apartment = new ApartmentModel(apartmentNumber:  snapshot.data['apartment']['sonha'], typeHome:snapshot.data['apartment']['loainha']);
    model.startTime = snapshot.data['thoigianbatdau'];
    model.putByTime = snapshot.data['thoigiandang'];
    model.note = snapshot.data['ghichu'];
    model.paymentMethod = PaymentMethod('0', snapshot.data['method'], money: double.parse(snapshot.data['money']));
    model.tip = snapshot.data['tip'];
    model.weightWork = Item(snapshot.data['weightWork']['idItem'], snapshot.data['weightWork']['thoigianlam'], soNguoiLam: snapshot.data['weightWork']['songuoilam']);
    // get data in model 3
    model.numberPersonEat = snapshot.data['numberPersonEat'];
    model.numberFood = snapshot.data['numberFood'];
    model.hasFruit = snapshot.data['hasFruit'];
    model.goMarket = snapshot.data['goMarket'];
    model.taste = snapshot.data['taste'];
    return model;
  }

}