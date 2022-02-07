import 'package:sample_one/src/my_firebase/cloud_firestore/get_store.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/utils/data_holder.dart';

class CheckTimeWork{

  static Future<bool> checkJobNotPartner(String idCustomer, String idDetail) async{
    bool notPartner = false;
    try{
      await store.collection('chitietcongviec').document(idDetail).get().then((value){
        var startTime = formatterHasHour.parse(value.data['thoigianbatdau']);
        int soNguoiLam = value.data['weightWork']['songuoilam'];
        List listIdPartner = [];
        if(startTime.isAfter(DateTime.now())){
          GetStore.getListIdPartnerOfJob(idDetail).then((value){
            listIdPartner = value;
          });

          if(listIdPartner.length <soNguoiLam){
            notPartner = true;
          }
        }else{
          notPartner = false;
        }
      });
      print('not----- $notPartner');
      return notPartner;
    }catch(err){
      return false;
    }
  }

}