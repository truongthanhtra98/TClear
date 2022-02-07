import 'package:flutter/material.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/date_time_picker.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/location_work_text_field.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/my_radio_button_dish.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/my_radio_button_fruit.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/my_radio_button_market.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/my_radio_button_taste.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/my_slider.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/time_job.dart';
import 'package:sample_one/src/utils/form_page.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/apartment_text_field.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/button_next.dart';

class Service3 extends StatefulWidget {
  final ServiceModel serviceModel;

  Service3(this.serviceModel);
  @override
  _Service3State createState() => _Service3State();
}

class _Service3State extends State<Service3> {
  ModelService3 modelService3 = new ModelService3();

  @override
  Widget build(BuildContext context) {
    return FormPage(
      textBar: '${widget.serviceModel.nameService}',
      content: Provider<PaymentBloc>(
          create: (_) => PaymentBloc(), child: _content()),);
  }

  Widget _content() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              LocationWorkTextField(detailPutService: modelService3,),
              ApartmentTextField(detailPutService: modelService3,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("Thông tin bữa ăn", style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  width: 300,
                  height: 50,
                  color: Colors.white,
                  child: MySlider(modelService3)),
              MyRaidoButtonDish(modelService3),
              MyRaidoButtonTaste(modelService3),
              MyRaidoButtonFruit(modelService3),
              WorkTime(modelService3, DateTime.now().add(Duration(hours: 1, minutes: 30))),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              MyRaidoButtonMarket(modelService3),
              //RepeatSwitch(modelService1),
              SizedBox(
                height: 15.0,
              ),
              //PetSwitch(modelService1),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: ButtonNext(detailPutService: modelService3, serviceModel: widget.serviceModel,),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
