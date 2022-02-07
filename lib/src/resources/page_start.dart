import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/images.dart';

class PageStart extends StatefulWidget {
  @override
  _PageStartState createState() => _PageStartState();
}

class _PageStartState extends State<PageStart> {

  bool connected = true;
  bool loading = false;
  var connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    //checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();
    return Scaffold(
      body: Container(
        color: orangeBackground,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconLogo, color: white, width: 100, height: 100,),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(child: CircularProgressIndicator(backgroundColor: white,), height: 10, width: 10,),
                  SizedBox(width: 10,),
                  Text('Xin chào đến với TClear, vui lòng đợi trong giây lát', style: TextStyle(color: white),),
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: connected? SizedBox(): GestureDetector(
        onTap: (){
          setState(() {
            loading = true;
          });
          checkInternet();
        },
        child: Container(
            padding: EdgeInsets.all(10),
            color: grey1,
            width: MediaQuery.of(context).size.width,
            child: loading ? Row(
              children: [
                Icon(Icons.autorenew, color: white,),
                SizedBox(width: 20,),
                Text('Đang kết nối lại', style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 14),),
              ],
            ) : Row(
              children: [
                Icon(Icons.autorenew, color: GREEN,),
                SizedBox(width: 20,),
                Text('Bấm vào đây để kết nối lại Internet', style: TextStyle(color: GREEN, fontWeight: FontWeight.bold, fontSize: 14),),
              ],
            )),
      ),
    );
  }

  void checkInternet(){

    connectivity = new Connectivity();
    Future.delayed(Duration(seconds: 2), (){
      setState(() {
        subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
            connected = true;
            Future.delayed(Duration(seconds: 1), (){
              Navigator.of(context).pushNamedAndRemoveUntil('/app', (route) => false, arguments: 0);
            });
          }else{
            connected = false;
          }
        });
      });
      setState(() {
        if(!connected){
          loading = false;
        }
      });
    });

  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

}
