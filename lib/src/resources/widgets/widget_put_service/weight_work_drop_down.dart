import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/items_dropdownlist.dart';
import 'package:sample_one/src/event/payment_event.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/strings.dart';

class WeightWorkDropDown extends StatefulWidget {
  ModelService1 detailPutService;
  WeightWorkDropDown(this.detailPutService);

  @override
  _WeightWorkDropDownState createState() => _WeightWorkDropDownState();
}

class _WeightWorkDropDownState extends State<WeightWorkDropDown> {
  List<Item> attribute = Item.getWorkIn();
  Item selectedAttribute;

  @override
  void initState() {
    super.initState();
      selectedAttribute = attribute[0];
      widget.detailPutService.weightWork = new Item(selectedAttribute.idItem, selectedAttribute.thoiGian,
        dienTich: selectedAttribute.dienTich, soPhong: selectedAttribute.soPhong);;
  }
  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of<PaymentBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'LÀM TRONG',
              style: TextStyle(
                color: grey,
                fontSize: 12.0,
              ),
            ),
            Spacer(),
            GestureDetector(
              child: Text(
                'Nghĩa là gì?',
                style: TextStyle(
                  color: GREEN,
                  fontSize: 12.0,
                ),
              ),
              onTap: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return DialogWeightExplain();
                    });
              },
            ),
          ],
        ),
        Container(
          height: 40.0,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: grey, width: 1)),
          child: DropdownButton<Item>(
            isExpanded: true,
            value: selectedAttribute,
            onChanged: (Item Value) {
              int time = 0;
              setState(() {
                selectedAttribute = Value;
                //widget.detailPutService.weightWork = selectedAttribute;
                time = selectedAttribute.thoiGian;
                if(widget.detailPutService.cooking){
                  time +=1;
                }
                if(widget.detailPutService.iron){
                  time +=1;
                }
                widget.detailPutService.weightWork = new Item(selectedAttribute.idItem, time,
                    dienTich: selectedAttribute.dienTich, soPhong: selectedAttribute.soPhong);

                bloc.event.add(PaymentEvent(widget.detailPutService));
              });
            },
            items: attribute.map((Item attribute) {
              return DropdownMenuItem<Item>(
                value: attribute,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${attribute.thoiGian}h",
                        style: TextStyle(color: BLACK),
                      ),
                    ),

                    Expanded(
                        child: Text(
                          attribute.dienTich,
                          style: TextStyle(color: BLACK),
                        )),

                    Expanded(
                        child: Text(
                          attribute.soPhong,
                          style: TextStyle(color: BLACK),
                        ))
                    ,
                  ],
                ),
              );
            }).toList(),
            underline: Container(
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}

class DialogWeightExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Làm trong nghĩa là gì?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
      content: Text(
        'Đây là thời gian mà CTV sẽ làm tại nhà bạn. Bạn vui lòng ước tính chính xác diện tích cần dọn dẹp, để có'
            'thời gian làm phù hợp. Tránh tình trạng CTV không làm kịp do nhiều thời gian và diện tích quá rộng.',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            dong,
            style: TextStyle(color: GREEN, fontSize: 20.0),
          ),
        )
      ],
    );
  }
}