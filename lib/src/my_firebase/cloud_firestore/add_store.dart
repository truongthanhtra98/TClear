import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/history_model.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';

class AddStore {

  static void addDatDichVu(
      UserModel userModel, DetailPutService detailPutService) async {
    //add detail work
    DocumentReference storeDetail =
    await store.collection('chitietcongviec').add(detailPutService.toMap());
    //repeat for model service 1
    if(detailPutService is ModelService1){
      if(detailPutService.mapRepeat.containsValue(true)){
        store.collection('dangvieclam').document(userModel.id).setData({
          'list_repeat': FieldValue.arrayUnion([
            storeDetail.documentID])
        }, merge: true);
      }
    }
    addTableDangviec(userModel.id, storeDetail.documentID);
  }

  static void addTableDangviec(String idUser, String maDetail) {
    store.collection('dangvieclam').document(idUser).setData({
      'list_work': FieldValue.arrayUnion([
        maDetail
      ])
    }, merge: true).then((_) {
      print('Add dangvieclam sucessly');
    }).catchError((err) {
      print(err);
    });
  }

  static void addHistory(HistoryModel historyModel) {
    store.collection('lichsudangviec').document(historyModel.idUser).setData({
      'list_history': FieldValue.arrayUnion([historyModel.toMap()])
    }, merge: true).then((_) {
      print('Sucess history model');
    }).catchError((err) {
      print(err);
    });
  }

  static void addFinal(String content){
    store.collection('gopy').document('themdichvu').setData({
      'list_gopy': FieldValue.arrayUnion([content])
    }, merge:  true).then((value) => print('Gop y success')).catchError((err){
      print(err);
    });
  }

  static void addError(String content){
    store.collection('gopy').document('gopybaoloi').setData({
      'list_gopy': FieldValue.arrayUnion([content])
    }, merge:  true).then((value) => print('Gop y success')).catchError((err){
      print(err);
    });
  }
}
