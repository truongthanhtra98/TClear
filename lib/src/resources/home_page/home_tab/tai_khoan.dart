import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_account/my_infor.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_my_app/benefit_page.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_my_app/contact_page.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_my_app/experience_page.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_my_app/feed_back.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_my_app/infor_page.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_my_app/juridical_page.dart';
import 'package:sample_one/src/resources/widgets/get_image_storage.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/form_page.dart';
import 'package:sample_one/src/utils/images.dart';
import 'package:sample_one/src/utils/strings.dart';

class TaiKhoan extends StatefulWidget {
  @override
  _TaiKhoanState createState() => _TaiKhoanState();
}

class _TaiKhoanState extends State<TaiKhoan> with AutomaticKeepAliveClientMixin{

  Widget _buildInfoUser(){
    return FutureBuilder(
        future: FirestoreInforUser.getUserModel(),
        builder: (context, userModel) {
          switch(userModel.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              UserModel user = userModel.data;
              return FlatButton(
                padding: EdgeInsets.all(0),
                highlightColor: Colors.white60,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyInforPage(user)));
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(40),
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
                          radius: 40.0,
                          child: ClipOval(
                            child: SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: user.image != null?
                              GetImageAvtStorage(user.image) :
                              Image.asset(imageAvatar, fit: BoxFit.fill,),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      //flex:3,
                      child: Container( 
                        height: 80.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${user.name}', style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text('${user.email}', style: TextStyle(
                              color: orangeBackground,
                            ), overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        }
    );
  }

  Widget _buildALine(String text, IconData icon, Widget page){
    return  Row(
      children: <Widget>[
        Icon(icon, color: Colors.grey,),
        FlatButton(

          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage(textBar: text, content: page,)));
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFECEFF1), width: 1.0),
          borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0))
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: _buildInfoUser(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildALine('Lợi ích khi sử dụng App', Icons.check_circle_outline, BenefitPage()),
                  _buildALine('Để có sự trải nghiệm tốt', Icons.insert_emoticon, ExperiencePage()),
                  _buildALine('Góp ý, báo lỗi', Icons.mail_outline, FeedbackPage()),
                  _buildALine('Liên hệ', Icons.headset_mic, ContactPage()),
                  _buildALine('Pháp lý', Icons.format_textdirection_r_to_l, JuridicalPage()),

                  Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app, color: Colors.grey,),
                      FlatButton(
                        onPressed: (){
                          showDialog(context: context, child: AlertDialog(
                            content: Text('Bạn muốn đăng xuất'),
                            actions: [
                              FlatButton(onPressed: () {
                                auth.signOut();
                                Navigator.of(context).pushNamedAndRemoveUntil('/app', (Route<dynamic> route) => false);
                              }, child: Text(dangXuat, style: TextStyle(color: GREEN,),)),
                              FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Đóng', style: TextStyle(color: BLACK,))),
                            ],
                          ));
                        },
                        child: Text(
                          dangXuat,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
