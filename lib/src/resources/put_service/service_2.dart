import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_2.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/area_work_dropdown.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/date_time_picker.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/location_work_text_field.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/apartment_text_field.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/button_next.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/detail_job.dart';
import 'package:sample_one/src/utils/form_page.dart';

class Service2 extends StatefulWidget {
  final ServiceModel serviceModel;
  Service2(this.serviceModel);

  @override
  _Service2State createState() => _Service2State();
}

class _Service2State extends State<Service2> {
  ModelService2 modelService2 = new ModelService2();

  @override
  Widget build(BuildContext context) {
    return FormPage(
      textBar: '${widget.serviceModel.nameService}',
      content: Provider<PaymentBloc>(
          create: (_) => PaymentBloc(), child: _content()),
    );
  }

  Widget _content(){
    return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      LocationWorkTextField(detailPutService: modelService2,),
                      ApartmentTextField(
                        detailPutService: modelService2,
                      ),
                      WorkTime(modelService2, DateTime.now().add(Duration(hours: 1, minutes: 30))),
                      SizedBox(
                        height: 15.0,
                      ),
                      AreaWorkDropDown(modelService2),
                      SizedBox(
                        height: 15.0,
                      ),
                      DetailJob(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: ButtonNext(detailPutService: modelService2, serviceModel: widget.serviceModel,),
                ),
              ],
            );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
