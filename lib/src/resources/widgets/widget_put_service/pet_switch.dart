import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';

class PetSwitch extends StatefulWidget {
  final ModelService1 detailPutService;

  PetSwitch(this.detailPutService);
  @override
  _PetSwitchState createState() => _PetSwitchState();
}

class _PetSwitchState extends State<PetSwitch> {
  bool _pet = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nhà có vật nuôi',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            GestureDetector(
              onTap: (){
                showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                  return DialogPetExplain();
                });
              },
              child: Text(
                "Nghĩa là gì?",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            )
          ],
        ),
        Spacer(),
        Switch(
          activeColor: Colors.orange,
          value: _pet,
          onChanged: (value) async {
           String hasPet = await showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
              return DialogPetSwitch();
            });

           setState(() {
             if(hasPet != '') {
               _pet = true;
               widget.detailPutService.pet = hasPet;
             }else{
               _pet = false;
               widget.detailPutService.pet = null;
             }
           });

          },
        ),
      ],
    );
  }


}

class DialogPetSwitch extends StatefulWidget {
  @override
  _DialogPetSwitchState createState() => _DialogPetSwitchState();
}

class _DialogPetSwitchState extends State<DialogPetSwitch> {
  var _petController = new TextEditingController();
  bool _isDog = false;
  bool _isCat = false;
  String _isPet = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Thêm vật nuôi',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Text(
                  'Tránh tình trạng người làm bị dị ứng với lông hoặc không thích vật nuôi.',
                  style: TextStyle(fontSize: 10.0),
                  textAlign: TextAlign.justify,
                )),
            Center(child: _checkBoxPet()),
            _textField(),

          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if(_isDog) _isPet += 'Chó ';
            if(_isCat) _isPet += 'Mèo ';
            if(_petController.text != null) _isPet += _petController.text;
            Navigator.of(context).pop(_isPet);
          },
          child: Text(
            'Đồng ý',
            style: TextStyle(
                color: Colors.green, fontSize: 16.0),
          ),
        )
      ],
    );
  }

  Widget _checkBoxPet() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Checkbox(
                    value: _isDog,
                    onChanged: (bool value) {
                      setState(() {
                        _isDog = value;
                      });
                    }),
                Text('Chó'),
              ],
            )),
        Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Checkbox(
                    value: _isCat,
                    onChanged: (bool value) {
                      setState(() {
                        _isCat = value;
                      });
                    }),
                Text('Mèo'),
              ],
            )),
      ],
    );
  }

  Widget _textField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'KHÁC',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 11.0,
          ),
        ),
        Container(
          height: 38.0,
          child: TextField(
            controller: _petController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            ),
          ),
        ),
      ],
    );
  }
}

class DialogPetExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Một số người làm bị dị ứng với lông hoặc không thích động vật.'
          ' Vậy nên bạn cần ghi rõ vật nuôi trong nhà nếu có, để tránh người làm nhận việc mà không làm được.',
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 16.0),
      ),
      contentPadding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0),
      actionsPadding: EdgeInsets.all(0.0),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Đóng',
            style: TextStyle(
                color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}


