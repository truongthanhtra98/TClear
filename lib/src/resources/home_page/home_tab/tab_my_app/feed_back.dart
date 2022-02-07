import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/add_store.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/strings.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var _textGopY = TextEditingController();
  String content = '';
  Widget _buildTextBox(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'GÓP Ý, BÁO LỖI',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),

        SizedBox(height: 5.0,),

        Container(
          height: 140.0,
          child: TextFormField(
            controller: _textGopY,
            keyboardType: TextInputType.text,
            maxLines: 5,
            //controller: phoneController,
            maxLength: 200,
            style: TextStyle(
              fontSize: 14.0,
            ),
            onChanged: (value){
              setState(() {
                content = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Nội dung góp ý(lớn hơn 10 và tối đa 200 ký tự)',
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendBtn() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
       // onPressed: onClickSignIn,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: GREEN,
        onPressed: content != ''? (){
          AddStore.addError(content);

          showDialog(context: context, child: AlertDialog(
            content: Text('Cảm ơn bạn đã gửi góp ý đến TClear!'),
            actions: [
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, child: Text(dong, style: TextStyle(color: BLACK),))
            ],
          ));
        } : null,
        child: Text(
          'Gửi',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.0,
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildText(){
    return Text('Nơi bạn góp ý, báo lỗi về ứng dụng. Chúng tôi sẽ ghi nhận và phát triển TClear ngày càng tốt hơn.');
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildTextBox(),
        _buildSendBtn(),
        SizedBox(height: 20.0,),
        _buildText(),
      ],
    );
  }
}
