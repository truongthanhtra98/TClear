import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/resources/home_page/home_tab/dang_viec.dart';
import 'package:sample_one/src/resources/home_page/home_tab/history_tap.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tai_khoan.dart';
import 'package:sample_one/src/resources/home_page/home_tab/viec_da_dang.dart';
import 'package:sample_one/src/resources/home_page/notification_page.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/images.dart';
import 'package:sample_one/src/utils/strings.dart';
import 'package:sample_one/src/valicators/check_connection.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  final int currentIndex;
  var phone;
  HomePage({Key key, @required this.user, this.currentIndex})
      : assert(user != null),
        phone = user.phoneNumber,
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  int _currentIndex;
  final pageController = PageController();

  final items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.edit),
      title: Text(dangViec),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.storage),
        title: Text(viecDaDang)
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      title: Text(lichSu),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),//
      title: Text(tClearCuaToi),
    ),
  ];

  final widgetOptions = [
    ScreenDangViec(),
    ViecDaDang(),
    HistoryPage(),
    TaiKhoan(),
  ];


  @override
  void initState(){
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('check connect == ${CheckConnection().checkConnection()}');
    return Scaffold(
      backgroundColor: grey1,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: orangeBackground,
        title: Row(
          children: [
            Image.asset(iconLogo, height: 30, width: 30, color: white,),
            SizedBox(width: 5,),
            Text(tClear,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.normal,
                  color: white
              ),
            ),
          ],
        ),
        elevation: 0.0,
        actions: <Widget>[
          StreamBuilder(
              stream: store.collection('thongbao').document(widget.user.uid).snapshots(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return IconButton(icon: Icon(Icons.notifications_none, size: 30.0, color: white, semanticLabel: 'Notification',), onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationPage(widget.user.uid)));
                    });
                  default:
                    DocumentSnapshot documentSnapshot = snapshot.data;
                    if(documentSnapshot.data != null && snapshot.data['list_notification'] != null){
                      List<dynamic> list = snapshot.data['list_notification'];
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          IconButton(icon: Icon(Icons.notifications_none, size: 30.0, color: white, semanticLabel: 'Notification',), onPressed: (){
                            //CheckTimeWork.checkTimeJob(widget.user.uid);
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationPage(widget.user.uid)));
                          }),
                          list.length != 0 ?CircleAvatar(child: Text('${list.length}',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),), radius: 8, backgroundColor: GREEN,) : SizedBox(),
                        ],
                      );
                    }else{
                      return   IconButton(icon: Icon(Icons.notifications_none, size: 30.0, color: white, semanticLabel: 'Notification',), onPressed: (){
                        //CheckTimeWork.checkTimeJob(widget.user.uid);
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationPage(widget.user.uid)));
                      });
                    }
                }
              }
          ),
          SizedBox(width: 20.0,),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 70.0,
              color: orangeBackground
          ),
          Container(
              child: IndexedStack(
                index: _currentIndex,
                children: widgetOptions,
              )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        selectedFontSize: 12.0,
        selectedItemColor: GREEN,
        items: items,
        onTap: onTap,
      ),
    );
  }

}
