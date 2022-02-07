import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password/password.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/utils/data_holder.dart';

class FirestoreInforUser{
//sign up
  static void addUserNew(String idUser, UserModel user){
    store.collection('users').document(idUser).setData(user.toMap()).whenComplete((){
      print('Added User Success');
    }).catchError((e){
      print(e);
    });
  }
  // check user đã tồn tại chưa
  static Future<bool> checkExist(String phoneNumber, String password) async{
    bool exists = false;
    try {
      await store.collection('users').where('phone', isEqualTo: phoneNumber).where('password', isEqualTo: Password.hash(password, algorithm)).getDocuments().then((value) {
        if (value.documents.length != 0)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }
  
  static Future<bool> checkPhone(String phoneNumber) async{
    bool exists = false;
    try {
      await store.collection('users').where("phone", isEqualTo: phoneNumber).getDocuments().then((doc){
        if (doc.documents.length!=0)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<UserModel> getUserModel() async{
    FirebaseUser user = await auth.currentUser();

    UserModel userModel = new UserModel();
    try{
      await store.collection('users').document(user.uid).get().then((value){
        if(value.exists)
            userModel = UserModel.fromMap(value.data, user.uid);
        else
            userModel = null;
      });
        return userModel;
    }catch(e){
      return null;
    }
  }

  static Future<bool> updatePassword(String idUser, String password) async{
    bool updateDone = false;
    try{
      await store.collection('users').document(idUser).updateData({
        'password': Password.hash(password, algorithm)
      }).then((value){
        print('Forgot success');
        updateDone = true;
      });
      return updateDone;
    }catch(e){
      return false;
    }

  }

  static void updateImageUser(String idUser, String image, String email, String name){
    store.collection('users').document(idUser).updateData({
      'image' : image,
      'name': name,
      'email': email
    }).then((value) => print('Update avt success')).catchError((err) => print(err));
  }
}

class Evaluate{
  static void addEvaluate(String idDetail, List<String> listIdPartner){
    store.collection('danhgia').document(idDetail).setData({
      'idPartner' : FieldValue.arrayUnion(listIdPartner),
      'star': 0,
    }).then((value) => print('Add Evaluate success'));
  }

  static void updateEvaluate(String idEvaluate, int star, String comment){
    store.collection('danhgia').document(idEvaluate).updateData({
      'star': star,
      'comment': comment,
    },).then((value) => print('Update Evaluate success'));
  }

  static Future<double> avgStar(String idPartner) async {
    double countStar = 0;
    try {
      await store
          .collection('danhgia')
          .where('idPartner', arrayContains: idPartner)
          .getDocuments()
          .then((value) {
        value.documents.forEach((result) {
          countStar += result.data['star'];
        });
        countStar = countStar / (value.documents.length);
      });
      return countStar;
    } catch (e) {
      return 0;
    }
  }

}