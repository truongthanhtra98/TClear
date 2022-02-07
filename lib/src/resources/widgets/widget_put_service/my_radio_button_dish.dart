import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';
import 'package:sample_one/src/event/payment_event.dart';

enum SingingCharacter { rd1, rd2, rd3 }

class MyRaidoButtonDish extends StatefulWidget {
  ModelService3 modelService3;

  MyRaidoButtonDish(this.modelService3, {Key key}) : super(key: key);

  @override
  _MyRaidoButtonDishState createState() => _MyRaidoButtonDishState();
}

class _MyRaidoButtonDishState extends State<MyRaidoButtonDish> {
  SingingCharacter _character = SingingCharacter.rd1;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<PaymentBloc>(context);
    return Row(
      children: <Widget>[
        Expanded(child: Text("Số món ăn")),
        Expanded(
          child: Row(
            children: <Widget>[
              Radio(
                value: SingingCharacter.rd1,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    widget.modelService3.numberFood = 2;
                    bloc.event.add(PaymentEvent(widget.modelService3));
                  });
                },
              ),
              Text('2'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Radio(
                value: SingingCharacter.rd2,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    widget.modelService3.numberFood = 3;
                  });
                },
              ),
              Text('3'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Radio(
                value: SingingCharacter.rd3,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    widget.modelService3.numberFood = 4;
                  });
                },
              ),
              Text('4'),
            ],
          ),
        ),
      ],
    );
  }
}
