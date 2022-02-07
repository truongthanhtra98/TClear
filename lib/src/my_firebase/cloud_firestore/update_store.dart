import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/remove_service.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';

class UpdateStore{

  static void removeNhanViec(String idPartner, String idDetail){
    store.collection('nhanviec').document(idPartner).updateData({
      'list_work' : FieldValue.arrayRemove([idDetail]),
    }).then((value) {
      print('Remove success');
      //UpdateStore.updateTableDangViecAfterRemove(idPartner, idDetail );
    } );
  }

  static void removeCalendar(String idPartner, String dayWork, String idDetail){
    store.collection('lichlamviec').document(idPartner).updateData({
      '${dayWork}' : FieldValue.arrayRemove([idDetail]),
    }).then((value){
      print('Remove Calendar success');
    });
  }

  static Future<bool> checkRepeat(String idUser, String idDetail) async{
    bool repeat = false;
    try{
      await store.collection('dangvieclam').document(idUser).get().then((data){
        List listRepeat = data.data['list_repeat'];
        if(listRepeat.contains(idDetail)){
          repeat = true;
        }else{
          repeat = false;;
        }
      });
      return repeat;
    }catch(e){
      return false;
    }

  }

  static void updateDetailForRepeat(String idDetail, String dayRepeat) async{
    await store.collection('chitietcongviec').document(idDetail).updateData({'thoigianbatdau': dayRepeat}).then((value){
      print('Update repeat success');
    }).catchError((err){
      print(err);
    });
  }

  static void updateDetail(String idDetail, String timeStart){
    store.collection('chitietcongviec').document(idDetail).updateData({'thoigianbatdau' : timeStart}
    ).then((value){
      print('Update detail success');
    }).catchError((err){
      print(err);
    });
  }
}