import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/add_job.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/apartment_text_field.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/button_next.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/date_time_picker.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/pet_switch.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/repeat_switch.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/weight_work_drop_down.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/location_work_text_field.dart';
import 'package:sample_one/src/utils/form_page.dart';

class Service1 extends StatefulWidget {
  final ServiceModel serviceModel;

  Service1(this.serviceModel);
  @override
  _Service1State createState() => _Service1State();
}

class _Service1State extends State<Service1> {
  ModelService1 modelService1 = new ModelService1();
  @override
  Widget build(BuildContext context) {
    return FormPage(
      textBar: '${widget.serviceModel.nameService}',
      content: Provider<PaymentBloc>(
          create: (_) => PaymentBloc(), child: _content()),
    );
  }

  Widget _content() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              //location work
              LocationWorkTextField(
                detailPutService: modelService1,
              ),
              //apartment work
              ApartmentTextField(
                detailPutService: modelService1,
              ),
              // day, hour work service
              WorkTime(modelService1, DateTime.now().add(Duration(hours: 1, minutes: 30))),
              SizedBox(
                height: 15.0,
              ),
              // khoi luong cong viec
              WeightWorkDropDown(modelService1),
              SizedBox(
                height: 15.0,
              ),
              // them dich vu
              AddJob(modelService1),

              RepeatSwitch(modelService1),
              SizedBox(
                height: 15.0,
              ),
              PetSwitch(modelService1),

              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: ButtonNext(
            detailPutService: modelService1,
            serviceModel: widget.serviceModel,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
