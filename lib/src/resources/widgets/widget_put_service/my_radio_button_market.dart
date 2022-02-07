import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';


enum SingingCharacter { rd1, rd2, rd3 }

class MyRaidoButtonMarket extends StatefulWidget {
  ModelService3 modelService3;
  MyRaidoButtonMarket(this.modelService3, {Key key}) : super(key: key);

  @override
  _MyRaidoButtonMarketState createState() => _MyRaidoButtonMarketState();
}

class _MyRaidoButtonMarketState extends State<MyRaidoButtonMarket> {
  SingingCharacter _character = SingingCharacter.rd1;

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("Người Làm Đi Chợ")),
        Expanded(
          child: Row(
            children: <Widget>[

              Radio(
                value: SingingCharacter.rd1,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    widget.modelService3.goMarket = true;
                  });
                },
              ),
              Text('Có'),
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
                    widget.modelService3.goMarket = false;
                  });
                },
              ),
              Text('không'),
            ],
          ),
        ),

      ],
    );
  }
}
