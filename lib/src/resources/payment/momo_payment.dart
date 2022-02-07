import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:momo_vn/momo_vn.dart';


class MomoPayment extends StatefulWidget {
  @override
  _MomoPaymentState createState() => _MomoPaymentState();
}

class _MomoPaymentState extends State<MomoPayment> {
  MomoVn _momoPay;
  PaymentResponse _momoPaymentResult;
  String _payment_status;
  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('THANH TOÁN QUA ỨNG DỤNG MOMO'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                child: Text('DEMO PAYMENT WITH MOMO.VN'),
                onPressed: () async {
                  MomoPaymentInfo options = MomoPaymentInfo(
                    merchantname: "TClear",
                    merchantcode: 'MOMORECV20200702',
                    appScheme: "momorecv20200702",
                    amount: 6000,
                    orderId: 'order123411',
                    orderLabel: 'order1234',
                    merchantnamelabel: "Nha thanh toan",
                    fee: 0,
                    description: 'Thu tiền dọn dẹp',
                    username: 'tho66535@gmail.com',
                    partner: 'toto',
                    extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                    isTestMode: true,
                  );
                  try {
                    _momoPay.open(options);
                  } catch (e) {
                    debugPrint(e);
                  }
                },
              ),
              Text(_payment_status ?? "CHƯA THANH TOÁN")
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }
  void _setState() {
    _payment_status = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess) {
      _payment_status += "\nTình trạng: Thành công.";
      _payment_status += "\nSố điện thoại: " + _momoPaymentResult.phonenumber;
      _payment_status += "\nExtra: " + _momoPaymentResult.extra;
      _payment_status += "\nToken: " + _momoPaymentResult.token;
    }
    else {
      _payment_status += "\nTình trạng: Thất bại.";
      _payment_status += "\nExtra: " + _momoPaymentResult.extra;
      _payment_status += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }
  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THÀNH CÔNG: " + response.phonenumber, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THẤT BẠI: " + response.message.toString(), timeInSecForIosWeb: 4);
  }
}