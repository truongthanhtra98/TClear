import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/apartment_model.dart';
import 'package:sample_one/src/data_models/items_dropdownlist.dart';
import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/data_models/payment_method.dart';

class ModelService1 extends DetailPutService{
  bool cooking;
  bool iron;
  bool mop;
  String pet;
  Map<String, dynamic> mapRepeat;

  ModelService1(){
    this.cooking = false;
    this.iron = false;
    this.mop = false;
    this.mapRepeat = {'CN' : false, 'T2': false, 'T3': false, 'T4': false, 'T5': false, 'T6': false, 'T7': false};
  }


  Map<String, dynamic> toMap(){
    Map<String, dynamic> mapChild = {
      'id': 'DV01',
      'weightWork':{
        'idItem': weightWork.idItem,
        'thoigianlam': weightWork.thoiGian,
        'dientich': weightWork.dienTich,
        'sophong':weightWork.soPhong,
        'songuoilam': 1,
      },
      'cooking': cooking,
      'iron': iron,
      'mop': mop,
      'pet': pet,
      'ngaylaplai': mapRepeat,
    };
    Map<String, dynamic> mapFinal = {};
    mapFinal.addAll(toMapAbstract());
    mapFinal.addAll(mapChild);
    return mapFinal;
  }

  @override
  double payment() {
    double total = 0;
    if(weightWork.idItem == null){
      total += 0;
    }
    if(weightWork.idItem == 1){
      total += 100;
    }
    if(weightWork.idItem == 2){
      total += 200;
    }
    if(weightWork.idItem == 3){
      total += 300;
    }
    if(weightWork.idItem == 4){
      total += 400;
    }

    if(cooking){
      total += 100;
    }

    if(iron){
      total += 100;
    }

    if(mop){
      total += 30;
    }

    return total*1000;
  }

  @override
  DetailPutService fromMap(AsyncSnapshot snapshot) {
    ModelService1 model = new ModelService1();
    model.idService = snapshot.data['id'];
    model.idDetail = snapshot.data.documentID;
    model.locationWork = new Location(formattedAddress:snapshot.data['location']['diachi'], lat: snapshot.data['location']['lat'], lng: snapshot.data['location']['lng']);
    model.apartment = new ApartmentModel(apartmentNumber:  snapshot.data['apartment']['sonha'], typeHome:snapshot.data['apartment']['loainha']);
    model.startTime = snapshot.data['thoigianbatdau'];
    model.putByTime = snapshot.data['thoigiandang'];
    model.note = snapshot.data['ghichu'];
    model.paymentMethod = PaymentMethod('0', snapshot.data['method'], money: double.parse(snapshot.data['money']));
    model.tip = snapshot.data['tip'];
    //model service1
    model.weightWork = Item(snapshot.data['weightWork']['idItem'], snapshot.data['weightWork']['thoigianlam'],dienTich: snapshot.data['weightWork']['dientich'], soPhong: snapshot.data['weightWork']['sophong'], soNguoiLam: snapshot.data['weightWork']['songuoilam']);
    model.cooking = snapshot.data['cooking'];
    model.mop = snapshot.data['mop'];
    model.iron = snapshot.data['iron'];
    model.pet = snapshot.data['pet'];
    model.mapRepeat = snapshot.data['ngaylaplai'];
    return model;
  }

}