import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/resources/widgets/get_image_storage.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/images.dart';

class InformationPartner extends StatelessWidget {
  final UserModel partner;
  InformationPartner(this.partner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin nhân viên'),
      ),
      body: _content(),
    );
  }

  Widget _content(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(80),
                boxShadow: [
                  BoxShadow(
                    color: grey,
                    blurRadius: 0.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 0.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: CircleAvatar(
                backgroundColor: white,
                radius: 81,
                child: ClipOval(
                  child: new SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: partner.image != null
                          ? GetImageAvtStorage(
                          partner.image)
                          : Image.asset(
                        imageAvatar,
                        fit: BoxFit.fill,
                      ))
                  ),
                ),
              ),
            ),
          SizedBox(height: 10,),
          Align(alignment: Alignment.center,child: Text('${partner.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),  textAlign: TextAlign.center,)),
          SizedBox(height: 20,),
          Text('Thông tin liện hệ', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text('Số điện thoại: ${partner.phone}'),
          SizedBox(height: 10,),
          Text('Email: ${partner.email}'),
        ],
      ),
    );
  }
}
