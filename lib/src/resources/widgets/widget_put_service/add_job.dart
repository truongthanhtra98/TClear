import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/event/payment_event.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/images.dart';

class AddJob extends StatefulWidget {
  ModelService1 modelService1;

  AddJob(this.modelService1);
  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  bool mop =false;
  bool cooking = false;
  bool iron = false;
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<PaymentBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'THÊM DỊCH VỤ',
          style: TextStyle(
            color: grey, fontSize: 12
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: iron? orangeBackground : white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: iron ? orangeBackground : grey, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: grey,
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                            offset: iron? Offset(2.0, 2.0) : Offset(0.0, 0.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Image.asset(imageIron, color:iron? white : orangeBackground,),
                    ),
                    onTap: (){
                      setState(() {
                        iron = !iron;
                        widget.modelService1.iron = iron;
                        if(iron){
                          widget.modelService1.weightWork.thoiGian += 1;
                        }else{
                          widget.modelService1.weightWork.thoiGian -= 1;
                        }
                        bloc.event.add(PaymentEvent(widget.modelService1));
                      });
                    },
                  ),
                  Text("Ủi đồ", style: TextStyle(fontSize: 14.0),),
                  Text(
                    "+1h",
                    style: TextStyle(color: grey, fontSize: 12.0),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: mop? orangeBackground : white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: mop ? orangeBackground : grey, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: grey,
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                            offset: mop? Offset(2.0, 2.0) : Offset(0.0, 0.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Image.asset(imageMop, color: mop? white : orangeBackground,),
                    ),
                    onTap: (){
                      setState(() {
                        mop = ! mop;
                        widget.modelService1.mop = mop;
                        bloc.event.add(PaymentEvent(widget.modelService1));
                      });
                    },
                  ),
                  Text("Mang theo dụng cụ", style: TextStyle(fontSize: 14.0), textAlign: TextAlign.center,),
                  Text(
                    "+30,000 VNĐ",
                    style: TextStyle(color: grey, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

}
