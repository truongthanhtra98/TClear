import 'dart:async';

import 'package:sample_one/src/base/base_bloc.dart';
import 'package:sample_one/src/base/base_event.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/event/payment_event.dart';

class PaymentBloc extends BaseBloc{
  StreamController<double> _streamControllerPayment = new StreamController<double>();

  Stream<double> get  streamPayment => _streamControllerPayment.stream;

  double totalMoney = 0;

  _payment(DetailPutService service){
    if(service.locationWork == null || service.apartment == null){
      print('Not payment');
    }else{
      totalMoney = service.payment();
      _streamControllerPayment.sink.add(totalMoney);
    }

  }

  @override
  void dispatchEvent(BaseEvent event) {
    if(event is PaymentEvent){
      _payment(event.service);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamControllerPayment.close();
  }
}