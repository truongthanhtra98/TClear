import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/notification_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/notification_store.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/form_page.dart';

class NotificationPage extends StatelessWidget {
  final String idUser;

  NotificationPage(this.idUser);

  @override
  Widget build(BuildContext context) {
    return FormPage(
      textBar: 'Thông báo',
      content: _content(),
    );
  }

  Widget _content(){
    return StreamBuilder(
        stream: store.collection('thongbao').document(idUser).snapshots(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              DocumentSnapshot documentSnapshot = snapshot.data;
              if(documentSnapshot.data != null && snapshot.data['list_notification'] != null && snapshot.data['list_notification'].length != 0){
                List<dynamic> list = snapshot.data['list_notification'];
                return Container(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index){
                        NotificationModel notificationModel = NotificationModel.fromMap(list[(list.length-1) - index]);
                        return ListTile(
                          title: _notification(notificationModel),
                          trailing: IconButton(icon: Icon(Icons.clear, color: grey,), alignment: Alignment.topRight, onPressed: (){
                            NotificationStore.deleteNotification(idUser, list[(list.length-1) - index]);
                          },),
                          contentPadding: EdgeInsets.all(0),
                        );
                      }),
                );
              }else{
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: Text('Không có thông báo nào')),
                );
              }
          }
        }
    );


  }

  Widget _notification(NotificationModel notificationModel){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //chủ đề(có người nhân việc, công việc hoàn thành)
        Text('${notificationModel.topic}', style: TextStyle(fontWeight: FontWeight.bold),),
        //time
        Text('${notificationModel.time}', style: TextStyle(fontSize: 10),),
        // nội dung(NG Van A dã nhan viẹc) (dánh giá người giúp việc.)
        Text('${notificationModel.content}',),
        Divider(),
      ],
    );
  }
}
