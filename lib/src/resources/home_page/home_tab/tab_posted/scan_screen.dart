import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/utils/colors.dart';

class ScanScreen extends StatefulWidget {
  final String idCustomer;
  final String dayWork;
  final DetailPutService detail;
  final List<String> listIdPartner;
  ScanScreen(this.idCustomer, this.detail, this.dayWork, this.listIdPartner);

  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Xác minh người giúp việc'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: RaisedButton(
                    color: GREEN,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: Text('Bắt đầu xác minh')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        //this.barcode = barcode;
        if(widget.listIdPartner.contains(barcode)){
          this.barcode = 'Mã xác minh chính xác';
          //CheckTimeWork.tableDangViec(widget.idCustomer, widget.detail.idDetail, widget.dayWork, widget.listIdPartner);
          //Evaluate.addEvaluate(widget.detail.idDetail, widget.listIdPartner);
//          UpdateStore.checkRepeat(widget.idCustomer, widget.detail.idDetail).then((value){
//            if(value){
//              if(widget.detail is ModelService1){
//                ModelService1 modelService1 = widget.detail;
//                UpdateStore.updateDetailForRepeat(modelService1.idDetail, CheckDayRepeat.dayRepeatNext(modelService1.mapRepeat));
//                AddServiceDatabase.addTableDangviec(widget.idCustomer, modelService1.idDetail);
//              }
//            }
//          });
          showDialog(
              context: context,
              barrierDismissible: false,
              child: AlertDialog(
                content: Text('Thông tin xác minh chính xác'),
                actions: [
                  FlatButton(onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil('/app', (Route<dynamic> route) => false, arguments: 1);
                  }, child: Text('Đóng', style: TextStyle(color: BLACK),)),

                  FlatButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text('Tiếp tục xác minh', style: TextStyle(color: GREEN),))
                ],
              )
          );
        }else{
          this.barcode = 'Thông tin xác minh không đúng';
        }
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'Bạn chưa xác minh');
    } catch (e) {
      setState(() => this.barcode = 'Đã xảy ra lỗi bạn hãy thử lại');
    }
  }
}