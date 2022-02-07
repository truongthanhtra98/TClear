import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';

enum SingingCharacter { rd1, rd2, rd3 }

class MyRaidoButtonFruit extends StatefulWidget {
  ModelService3 modelService3;
  MyRaidoButtonFruit(this.modelService3, {Key key}) : super(key: key);

  @override
  _MyRaidoButtonFruitState createState() => _MyRaidoButtonFruitState();
}

class _MyRaidoButtonFruitState extends State<MyRaidoButtonFruit> {
  SingingCharacter _character = SingingCharacter.rd1;

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("Trái cây")),
        Expanded(
          child: Row(
            children: <Widget>[

              Radio(
                value: SingingCharacter.rd1,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    widget.modelService3.hasFruit = true;
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
                    widget.modelService3.hasFruit = false;
                  });
                },
              ),
              Text('Không'),
            ],
          ),
        ),

      ],
    );
  }
}
