import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JuridicalPage extends StatefulWidget {
  @override
  _JuridicalPageState createState() => _JuridicalPageState();
}

class _JuridicalPageState extends State<JuridicalPage> {
  // làm gì nhỉ à cái ảnh ở giữa
  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            FlatButton(
              padding: EdgeInsets.all(0.0),
                onPressed: _onClick1,
                child: Row(
                  children: <Widget>[
                    Text('Điều khoản sử dụng', style: TextStyle(fontSize: 15.0),),
                    Spacer(),
                    Icon(Icons.chevron_right),
                  ],
                ),
            ),

            Container(
              height: 1.0,
              color: Colors.grey,
              //margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
            ),

            FlatButton(
              padding: EdgeInsets.all(0.0),
              onPressed: _onClick1,
              child: Row(
                children: <Widget>[
                  Text('Chính sách bảo mật', style: TextStyle(fontSize: 15.0),),
                  Spacer(),
                  Icon(Icons.chevron_right,),
                ],
              ),
            ),


          ],
        ),

    );
  }

  void _onClick1(){

  }
}
