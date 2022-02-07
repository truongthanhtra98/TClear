import 'package:sample_one/src/base/base_event.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';

class PaymentEvent extends BaseEvent{
    DetailPutService service;

    PaymentEvent(this.service);

}