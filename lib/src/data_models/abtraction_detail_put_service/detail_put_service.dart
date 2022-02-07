import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/apartment_model.dart';
import 'package:sample_one/src/data_models/items_dropdownlist.dart';
import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/data_models/payment_method.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/utils/data_holder.dart';

abstract class DetailPutService{
  String idService;
  String idDetail;
  Location locationWork;
  ApartmentModel apartment;
  DateTime day;
  String startTime;
  String putByTime;
  String hour;
  String note;
  Item weightWork;
  //double money;
  PaymentMethod paymentMethod;
  UserModel contactUser;
  int tip;

  Map<String, dynamic> toMap();

  Map<String, dynamic> toMapAbstract(){
    return {
      'location':{
        'diachi': locationWork.formattedAddress,
        'lat' : locationWork.lat,
        'lng': locationWork.lng,
      },
      'thoigianbatdau': '${hour}, ${formatter.format(day).toString()}',
      'apartment': {
        'loainha': apartment.typeHome,
        'sonha': apartment.apartmentNumber,
      },
      'ghichu': note,
      'thoigiandang': formatterHasHour.format(DateTime.now()).toString(),
      'money': paymentMethod.money.toString(),
      'method': paymentMethod.method,
      'tip': tip,
      'thongtinlienhe': contactUser.toMapContact()
    };
  }

  DetailPutService fromMap(AsyncSnapshot snapshot);

  double payment();
}