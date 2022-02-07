
import 'dart:async';

import 'package:sample_one/src/valicators/validation.dart';

class DialogBloc{
  StreamController _apartController = new StreamController();

  Stream get apartmentStream => _apartController.stream;

// check textfield of dialog apartment
  bool isValidApartment(String apart){
    if(!Validation.isValidApartment(apart)){
      _apartController.sink.addError('Thông tin bắt buộc');
      return false;
    }
    _apartController.sink.add("ok");
    return true;
  }

  void dispose(){
    print('close');
    _apartController.close();
  }
}