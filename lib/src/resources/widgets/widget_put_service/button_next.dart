import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/resources/dialog/dialog_service/dialog_note.dart';
import 'package:sample_one/src/resources/payment/lien_he_va_thanh_toan.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';
import 'package:sample_one/src/utils/strings.dart';

class ButtonNext extends StatelessWidget {
  final DetailPutService detailPutService;
  final ServiceModel serviceModel;

  ButtonNext({this.detailPutService, this.serviceModel});


  @override
  Widget build(BuildContext context) {

    return Consumer<PaymentBloc>(
      builder: (context, bloc, child) => Container(
        width: double.infinity,
        child: StreamBuilder<double>(
            stream: bloc.streamPayment,
            builder: (context, snapshot) {
              return RaisedButton(
                onPressed: snapshot.data == null ? null : () async {
                  String timeStart = '${detailPutService.hour}, ${formatter.format(detailPutService.day).toString()}';
                  var formatterTimeStart = formatterHasHour.parse(timeStart);
                  //
                  if(!formatterTimeStart.isAfter(DateTime.now().add(Duration(hours: 1)))){
                    showDialog(context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Thời gian làm dịch vụ phải cách tầm 1 tiếng'),
                            actions: [
                              FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text(dong, style: TextStyle(color: BLACK),))
                            ],
                          );
                        });
                  }else{
                    DetailPutService detail = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogNote(detailPutService);
                        });
                    if(detail != null){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => LienHeVaThanhToan(detail, serviceModel, snapshot.data)));
                    }
                  }
                },
                padding: EdgeInsets.all(9.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: GREEN,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text( snapshot.data != null?
                    '${oCcy.format(snapshot.data)} VND/${detailPutService.weightWork.thoiGian}h' : "",
                      style: TextStyle(fontSize: 18.0, color: white),
                    ),

                    Spacer(),
                    Text(
                      tiepTheo,
                      style: TextStyle(
                        color: white,
                        letterSpacing: 0.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: white,
                      size: 32.0,
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

}
