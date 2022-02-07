import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';

class GetStore {
  static Future getListService() {
    return store.collection('dichvu').getDocuments();
  }

  static Future<List<String>> getListIdPartnerOfJob(String idDetail) async {
    List<String> listId = [];
    try {
      await store
          .collection('nhanviec')
          .where('list_work', arrayContains: idDetail)
          .getDocuments()
          .then((data) {
        List listData = data.documents;
        listData.forEach((document) {
          DocumentSnapshot documentSnapshot = document;
          listId.add(documentSnapshot.documentID);
        });
      });
      return listId;
    } catch (e) {
      return [];
    }
  }

  static Stream<List<dynamic>> getHistoryDone(String idUser) {
    List<dynamic> listHistory = [];
    return store
        .collection('lichsudangviec')
        .document(idUser)
        .snapshots()
        .map((snapshot) {

      listHistory = snapshot.data['list_history'];
      List listMap = [];
      listHistory.map((mapValue) {

        if (mapValue['status'] == 'ĐÃ XONG') {
          listMap.add(mapValue);
        }
      }).toList();
      return listMap.map((e) => e).toList();
    });
  }

  static Stream<List<dynamic>> getHistoryCancel(String idUser) {
    List<dynamic> listHistory = [];
    return store
        .collection('lichsudangviec')
        .document(idUser)
        .snapshots()
        .map((snapshot) {
      listHistory = snapshot.data['list_history'];
      List listMap = [];
      listHistory.map((mapValue) {
        if (mapValue['status'] == 'ĐÃ HỦY') {
          listMap.add(mapValue);
        }
      }).toList();
      return listMap.map((e) => e).toList();
    });
  }

  // get giùm thông kê công việc partner
  static Future<List> getThongKe() async{
    List _listThongKe = []; // nhân viên, gì đó// tiền count
    try{
      await store.collection('lichsunhanviec').getDocuments().then((value){
        List listDocument = value.documents;
          listDocument.map((e) async{

          });

      });
      print('kkkkk ${_listThongKe}');
      return _listThongKe;
    }catch(err){
      return [];
    }
   // history
  }

  static Stream<List<dynamic>> thongke() {
    List _listThongKe = [];
    return store
        .collection('lichsunhanviec')
        .snapshots()
        .map((snapshot){
      List listDocument = snapshot.documents;
      listDocument.map((mapValue) async{
        DocumentSnapshot snapshot = mapValue;
        String idUser = snapshot.documentID;
        UserModel userModel;
        await store.collection('userpartner').document(idUser).get().then((value) {
          userModel = UserModel.fromMap(value.data, idUser);
        });
        int count1 =0, count2 = 0, count3 =0;
        double money1 = 0, money2 =0, money3 =0;
        Map map = snapshot.data;
        List listHistory = map['list_history'];
        //his list
        print('list his ${listHistory}');
        listHistory.map((map){
          String idDV = map['idDV'];
          print('object id dvvvv ${idDV}');
          String money = map['money'];
          if(idDV == 'DV01'){
            count1++;
            money1 += double.parse(money);
          }
          if(idDV == 'DV02'){
            count2++;
            money2 += double.parse(money);
          }
          if(idDV == 'DV03'){
            count3++;
            money3 += double.parse(money);
          }
        }).toList();
        _listThongKe.add({'idUser': idUser, 'DV01' : {'count' : count1, 'money': money1}, 'DV02' : {'count' : count2, 'money': money2},
          'DV03' : {'count' : count3, 'money': money3},
        });
        print('lolo ${count1}');
      }).toList();
      print('fiaiaiaiai ${_listThongKe}');
      return _listThongKe.map((e) => e).toList();
    });
  }
}
