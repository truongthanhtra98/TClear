import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/history_model.dart';
import 'package:sample_one/src/data_models/notification_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/add_store.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/get_store.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/notification_store.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/remove_service.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/update_store.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';
import 'package:sample_one/src/valicators/check_day_repeat.dart';

class DialogReasonRemove extends StatefulWidget {
  String idUser;
  DetailPutService detailPutService;

  DialogReasonRemove(this.idUser, this.detailPutService);
  @override
  _DialogReasonRemoveState createState() => _DialogReasonRemoveState();
}

class _DialogReasonRemoveState extends State<DialogReasonRemove> {
  String reason;
  bool b1 = false, b2 = false, b3 = false, b4 = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Lý do hủy công việc',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width -100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: b1? Colors.green : Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF2F2F2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child: FlatButton(
                onPressed: (){
                  setState(() {
                    b1 = ! b1;
                    b2 = b3 = b4 = false;
                    if(b1){
                      reason = 'Bận việc đột xuất';
                    }else{
                      reason = '';
                    }
                  });
                },
                child: Text('Bận việc đột xuất', style: TextStyle(color: b1? Colors.green : Colors.black),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width -100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: b2? Colors.green : Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF2F2F2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child: FlatButton(
                onPressed: (){
                  setState(() {
                    setState(() {
                      b2 = ! b2;
                      b1 = b3 = b4 = false;
                      if(b2){
                        reason = 'Đăng nhầm ngày';
                      }else{
                        reason = '';
                      }
                    });
                  });
                },
                child: Text('Đăng nhầm ngày', style: TextStyle(color: b2? Colors.green : Colors.black),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width -100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: b3? Colors.green : Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF2F2F2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child: FlatButton(
                onPressed: (){
                  setState(() {
                    b3 = ! b3;
                    b1 = b2 = b4 = false;
                    if(b3){
                      reason = 'Không có người nhận viêc';
                    }else{
                      reason = '';
                    }
                  });
                },
                child: Text('Người làm có báo không đến được', textAlign: TextAlign.center, style: TextStyle(color: b3? Colors.green : Colors.black),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width -100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: b4? Colors.green: Colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF2F2F2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child: FlatButton(
                onPressed: (){
                  setState(() {
                    b4 = ! b4;
                    b1 = b2 = b3 = false;
                    if(b4){
                      reason = 'Không cần công việc này nữa';
                    }else{
                      reason = '';
                    }
                  });
                },
                child: Text('Không cần công việc này nữa', style: TextStyle(color: b4? Colors.green : Colors.black),),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width -100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFF2F2F2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child: TextFormField(
                  maxLines: 3,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Lý do khác',
                  ),
                  onChanged: (value){
                    if(value != null && value != ''){
                      setState(() {
                        b1 = b2 = b3 = b4 = false;
                        reason = value;
                      });
                    }else{
                      setState(() {
                        reason = '';
                      });
                    }
                  },
                )
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      //titlePadding: EdgeInsets.all(0),
      actions: <Widget>[
        FlatButton(
          //start success button
            onPressed: reason == '' ? null : () {
              var startTime = formatterHasHour.parse(widget.detailPutService.startTime);
              //create history model
              HistoryModel historyModel = HistoryModel(idUser: widget.idUser, idDetail: widget.detailPutService.idDetail,
                  reason: reason, status: 'ĐÃ HỦY' , timeStart: widget.detailPutService.startTime, idDV: widget.detailPutService.idService, money: widget.detailPutService.paymentMethod.money.toString());
              //all this of partners
              GetStore.getListIdPartnerOfJob(widget.detailPutService.idDetail).then((listIdPartner){
                listIdPartner.forEach((idPartner) {
                  //remove nhanviec lich lam viec
                  UpdateStore.removeCalendar(idPartner, formatter1.format(startTime), widget.detailPutService.idDetail);
                  UpdateStore.removeNhanViec(idPartner, widget.detailPutService.idDetail);
                  NotificationStore.sendNotification(idPartner,
                      NotificationModel('Công việc bị hủy', 'Công việc vào ngày ${widget.detailPutService.startTime} đã bị hủy'));
                });
                //end all pasrtner
                // check repeat
                UpdateStore.checkRepeat(widget.idUser, widget.detailPutService.idDetail).then((value){
                  if(value){
                    //leave after remove
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return DialogCheckRepeat(widget.idUser, widget.detailPutService, historyModel);
                        });
                  }else{
                    //add history remove
                    AddStore.addHistory(historyModel);
                    //remove service
                    RemoveService.remove(widget.idUser, widget.detailPutService.idDetail);
                    //leave after remove
                    Navigator.of(context).pop();
                    // show dialog finish
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return DialogFinishRemove('Công việc đã được hủy');
                        });
                  }
                });
              });
              //end success
            },
            child: Text('Hủy công việc',  style: TextStyle(color: GREEN, fontSize: 20.0),)
        ),
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text(
          'Đóng',
          style: TextStyle(color: BLACK, fontSize: 20.0),
        ),)
      ],
    );
  }

}

class DialogFinishRemove extends StatelessWidget {
  String content;
  DialogFinishRemove(this.content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Đóng',
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}

class DialogCheckRepeat extends StatelessWidget {
  String idUser;
  DetailPutService detailPutService;
  HistoryModel historyModel;
  DialogCheckRepeat(this.idUser, this.detailPutService, this.historyModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Bạn có muốn tiếp tục lịch lặp lại cho công việc này không?'),
      actions: [
        //button hủy
        FlatButton(onPressed: (){
          //remove service
          RemoveService.remove(idUser, detailPutService.idDetail);
          RemoveService.removeRepeat(idUser, detailPutService.idDetail);
          //add history remove
          AddStore.addHistory(historyModel);

          Navigator.of(context).pop();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return DialogFinishRemove('Công việc đã được hủy');
              });
        }, child: Text('Hủy lặp lại', style: TextStyle(color: BLACK),)),
        //button rêpat
        FlatButton(onPressed: (){
          var startTime = formatterHasHour.parse(detailPutService.startTime);
            ModelService1 modelService1 = detailPutService;
          //add history remove
          AddStore.addHistory(historyModel);
            UpdateStore.updateDetailForRepeat(modelService1.idDetail, CheckDayRepeat.dayRepeatNext(modelService1.mapRepeat, startTime));
            Navigator.of(context).pop();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return DialogFinishRemove('Công việc hôm nay đã được hủy và hệ thống đã đăng lịch lặp lại');
                });

        }, child: Text('Tiếp tục', style: TextStyle(color: GREEN),))
      ],
    );
  }
}



