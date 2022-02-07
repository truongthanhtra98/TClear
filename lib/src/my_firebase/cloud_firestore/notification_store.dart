import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_one/src/data_models/notification_model.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';

class NotificationStore{
  static void sendNotification(String idPartner, NotificationModel notificationModel){
    store.collection('thongbaopartner').document(idPartner).setData({
      'list_notification' : FieldValue.arrayUnion([notificationModel.toMap()])
    }, merge: true).then((value){
      print("Add notification access");
    }).catchError((err) => print(err));
  }

  static void deleteNotification(String idUser, Map mapNotification){
    store.collection('thongbao').document(idUser).updateData({
      'list_notification' : FieldValue.arrayRemove([mapNotification])
    }).then((value) {
      print('Remove notification success');
    }).catchError((err){
      print(err);
    });
  }
}