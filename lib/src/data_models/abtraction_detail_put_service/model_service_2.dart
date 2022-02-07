import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/apartment_model.dart';
import 'package:sample_one/src/data_models/items_dropdownlist.dart';
import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/data_models/payment_method.dart';

class ModelService2 extends DetailPutService{


  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapChild = {
      'id': 'DV02',
      'weightWork':{
        'idItem': weightWork.idItem,
        'thoigianlam': weightWork.thoiGian,
        'dientich': weightWork.dienTich,
        'songuoilam':weightWork.soNguoiLam,
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

    if(weightWork.idItem == null){
      total += 0;
    }
    if(weightWork.idItem == 1){
      total += 200;
    }
    if(weightWork.idItem == 2){
      total += 300;
    }
    if(weightWork.idItem == 3){
      total += 450;
    }

    return total*1000;
  }

  @override
  DetailPutService fromMap(AsyncSnapshot snapshot) {
    ModelService2 model = new ModelService2();
    model.idService = snapshot.data['id'];
    model.idDetail = snapshot.data.documentID;
    model.locationWork = new Location(formattedAddress: snapshot.data['location']['diachi'], lat: snapshot.data['location']['lat'], lng: snapshot.data['location']['lng']);
    model.apartment = new ApartmentModel(apartmentNumber:  snapshot.data['apartment']['sonha'], typeHome:snapshot.data['apartment']['loainha']);
    model.weightWork = Item(snapshot.data['weightWork']['idItem'], snapshot.data['weightWork']['thoigianlam'],dienTich: snapshot.data['weightWork']['dientich'], soNguoiLam: snapshot.data['weightWork']['songuoilam']);
    model.startTime = snapshot.data['thoigianbatdau'];
    model.putByTime = snapshot.data['thoigiandang'];
    model.note = snapshot.data['ghichu'];
    model.paymentMethod = PaymentMethod('0', snapshot.data['method'], money: double.parse(snapshot.data['money']));
    model.tip = snapshot.data['tip'];
    return model;
  }

}