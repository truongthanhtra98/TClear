import 'dart:async';

import 'package:connectivity/connectivity.dart';

class CheckConnection{
  var connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  CheckConnection(){
    connectivity = new Connectivity();
  }
  bool checkConnection(){
    bool connected = false;
        subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
            connected = true;
          }else{
            connected = false;
          }
        });
    return connected;
  }
}