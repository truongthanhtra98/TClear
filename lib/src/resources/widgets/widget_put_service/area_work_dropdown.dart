import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/items_dropdownlist.dart';
import 'package:sample_one/src/event/payment_event.dart';

class AreaWorkDropDown extends StatefulWidget {
  DetailPutService detailPutService;
  AreaWorkDropDown(this.detailPutService);

  @override
  _AreaWorkDropDownState createState() => _AreaWorkDropDownState();
}

class _AreaWorkDropDownState extends State<AreaWorkDropDown> {
  List<Item> attribute = Item.getArea();
  Item selectedAttribute;

  @override
  void initState() {
    super.initState();
    if(widget.detailPutService.weightWork != null){
      selectedAttribute = widget.detailPutService.weightWork;
    }else{
      selectedAttribute = attribute[0];
    }
    widget.detailPutService.weightWork = selectedAttribute;
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
              'DIỆN TÍCH',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            Spacer(),
            GestureDetector(
              child: Text(
                'Nghĩa là gì?',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12.0,
                ),
              ),
              onTap: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return DialogAreaExplain();
                    });
              },
            ),
          ],
        ),
        Container(
          height: 40.0,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: Colors.grey, width: 1)),
          child: DropdownButton<Item>(
            isExpanded: true,
            value: selectedAttribute,
            onChanged: (Item Value) {
              setState(() {
                selectedAttribute = Value;
                widget.detailPutService.weightWork = selectedAttribute;
                bloc.event.add(PaymentEvent(widget.detailPutService));
              });
            },
            items: attribute.map((Item attribute) {
              return DropdownMenuItem<Item>(
                value: attribute,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        attribute.dienTich,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    Expanded(
                        flex: 1,
                        child: Text(
                          '${attribute.soNguoiLam} người',
                          style: TextStyle(color: Colors.black),
                        )),

                    Expanded(
                        flex: 1,
                        child: Text(
                          "${attribute.thoiGian}h",
                          style: TextStyle(color: Colors.black),
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

class DialogAreaExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Diện tích nhà là gì?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
      content: Text(
        'Là tổng diện tích đang sử dụng mà bạn cần dọn dẹp.\n\n'
            'Ví dụ:\n- Đối với căn hộ là diện tích căn hộ.\n'
            '- Đối với nhà ở hay biệt thự là tôgr diện tích của sàn nhân với số lầu.',
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
            'Đóng',
            style: TextStyle(color: Colors.green, fontSize: 20.0),
          ),
        )
      ],
    );
  }
}