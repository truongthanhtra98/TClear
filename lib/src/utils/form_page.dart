import 'package:flutter/material.dart';
import 'package:sample_one/src/utils/colors.dart';

class FormPage extends StatefulWidget {
  String textBar;
  Widget content;

  FormPage({this.textBar, this.content});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey1,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: orangeBackground,
        title: Text('${widget.textBar}' ,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: white
          ),
        ),
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 70.0,
            color: orangeBackground,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: BoxDecoration(
                color: white,
                border: Border.all(color: Color(0xFFECEFF1), width: 1.0),
                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0))
            ),
            child: widget.content,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
