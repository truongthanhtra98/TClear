import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';

enum SingingCharacter { rd1, rd2, rd3 }

class MyRaidoButtonTaste extends StatefulWidget {
  ModelService3 modelService3;
  MyRaidoButtonTaste(this.modelService3, {Key key}) : super(key: key);

  @override
  _MyRaidoButtonTasteState createState() => _MyRaidoButtonTasteState();
}

class _MyRaidoButtonTasteState extends State<MyRaidoButtonTaste> {
  SingingCharacter _character = SingingCharacter.rd1;

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("Khẩu vị")),
        Expanded(
          child: Row(
            children: <Widget>[
              Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: SingingCharacter.rd1,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    widget.modelService3.taste = 'Bắc';
                  });
                },
              ),
              Text('Bắc'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[

              Expanded( 
                child: Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: SingingCharacter.rd2,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character = value;
                      widget.modelService3.taste = 'Trung';
                    });
                  },
                ),
              ),
              Expanded(child: Text('Trung')),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[

              Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: SingingCharacter.rd3,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    widget.modelService3.taste = 'Nam';
                  });
                },
              ),
              Text('Nam'),
            ],
          ),
        ),
      ],
    );
  }
}
