
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InforPage extends StatefulWidget {
  @override
  _InforPageState createState() => _InforPageState();
}

class _InforPageState extends State<InforPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.info_outline),
              SizedBox(width: 15.0,),
              Text('Phiên bản hiện tại', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('2.24.1', style: TextStyle(color: Colors.orange, fontSize: 12.0),),
                  SizedBox(height: 5.0,),
                  Text('Build 202514', style: TextStyle(fontSize: 12.0),),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.star_border),
              FlatButton(
                  onPressed: _onClick,
                  child: Text('Đánh dấu ứng dụng TClear', style: TextStyle(fontSize: 15.0),), ),
            ],
          )
        ],
      ),
    );
  }
  void _onClick(){

  }
}
