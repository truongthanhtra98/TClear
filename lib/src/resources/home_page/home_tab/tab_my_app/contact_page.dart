import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/images.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 60,
          child: Center(
            child: CircleAvatar(child: Image.asset(iconLogo, height: 50, width: 50, color: orangeBackground,), radius: 40.0, backgroundColor: Colors.white,),
          ),
        ),

        Text('Chúng tôi luôn đồng hành cùng bạn', textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

        SizedBox(height: 10,),

        Container(
          height: 100,
          child:  Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child:  Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Liên hệ chúng tôi nếu bạn cần hỗ trợ', style: TextStyle(fontSize: 15.0),),
                    SizedBox(height: 10.0,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone, color: Colors.lightGreen, size: 20.0,),
                        SizedBox(width: 15.0,),
                        Text('1900911100', style: TextStyle(color: Colors.lightGreen, fontSize: 18.0),),
                      ],
                    ),
                  ],
                ),
              )
          ),
        ),

        SizedBox(height: 20,),

        Container(
          height: 100,
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Email hỗ trợ', style: TextStyle(fontSize: 15.0),),
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.email, color: Colors.lightGreen, size: 20.0,),
                      SizedBox(width: 15.0,),
                      Text('email@email.com', style: TextStyle(color: Colors.lightGreen, fontSize: 15.0), )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),


      ],
    );
  }
}
