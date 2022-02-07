import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';

class RemoveService{
  static void remove(String idCustomer,String idDetail){
    store.collection('dangvieclam').document(idCustomer).updateData({
      'list_work': FieldValue.arrayRemove([idDetail])
    }).then((_){
      print('Deleted Finish');
    }).catchError((err){
      print(err);
    });
  }

  static void removeRepeat(String idCustomer, String idDetail){
    store.collection('dangvieclam').document(idCustomer).updateData({
      'list_repeat': FieldValue.arrayRemove([idDetail])
    }).then((_){
      print('Deleted Finish');
    }).catchError((err){
      print(err);
    });
  }
}