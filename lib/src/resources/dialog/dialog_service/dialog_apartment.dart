import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/bloc/dialog_bloc.dart';
import 'package:sample_one/src/data_models/apartment_model.dart';
import 'package:sample_one/src/utils/colors.dart';

class MyChoice {
  String choice;
  int index;

  MyChoice({this.choice, this.index});
}

class DialogApartment extends StatefulWidget {
  @override
  _DialogApartmentState createState() => _DialogApartmentState();
}

class _DialogApartmentState extends State<DialogApartment> {
  String default_choice = "Nhà phố";
  int default_index = 0;
  ApartmentModel apartmentModel = new ApartmentModel();
  List<MyChoice> choices = [
    MyChoice(index: 0, choice: "Nhà phố"),
    MyChoice(index: 1, choice: "Căn hộ"),
    MyChoice(index: 2, choice: "Biệt thự"),
  ];

  bool nha = false;
  bool canHo = false;
  bool bietThu = false;
  DialogBloc bloc = new DialogBloc();
  var _apartmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SingleChildScrollView(
        child: Container(
          height: 300,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: choices
                        .map((data) =>
                        Expanded(flex: 1,
                          child: RadioListTile(
                              activeColor: GREEN,
                              title: Text(data.choice),
                              value: data.index,
                              groupValue: default_index,
                              onChanged: (value){
                                setState(() {
                                  default_choice = data.choice;
                                  default_index = data.index;
                                });
                              }
                          ),
                        ),
                    ).toList(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _textField(),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Vui lòng chọn loại nhà, số nhà phù hợp, để CTV dễ dàng tìm kiếm',
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Đóng',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          if(bloc.isValidApartment(_apartmentController.text)){
                            apartmentModel.apartmentNumber = _apartmentController.text;
                            apartmentModel.typeHome = default_choice;
                            Navigator.pop(context, apartmentModel );
                          }
                          ;
                        },
                        child: Text(
                          'Đồng ý',
                          style: TextStyle(color: Colors.green, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkBox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                switch (title) {
                  case 'Nhà phố':
                    nha = value;
                    break;
                  case 'Căn hộ':
                    canHo = value;
                    break;
                  case 'Biệt thự':
                    bietThu = value;
                    break;
                }
              });
            }),
        Text(title),
      ],
    );
  }

  Widget _textField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'SỐ NHÀ/HẺM (NGÕ)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 11.0,
          ),
        ),
        Container(
          height: 38.0,
          child: TextField(
            controller: _apartmentController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            ),
          ),
        ),
        Container(
          height: 10.0,
          child: StreamBuilder(
            stream: bloc.apartmentStream,
            builder: (context, snapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  snapshot.hasError ? snapshot.error : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
