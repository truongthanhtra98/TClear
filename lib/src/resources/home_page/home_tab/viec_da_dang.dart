import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_2.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_4.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_posted/form_repeat.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/strings.dart';

import 'tab_posted/form_post_wait.dart';

class ViecDaDang extends StatefulWidget {

  @override
  _ViecDaDangState createState() => _ViecDaDangState();
}

class _ViecDaDangState extends State<ViecDaDang> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              color: white,
              child: TabBar(
                  isScrollable: false,
                  labelColor: GREEN,
                  indicatorColor: GREEN,
                  unselectedLabelColor: grey,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: choLam),
                    Tab(text: lapLai),
                  ]),
            ),
            Expanded(
              child: FutureBuilder(
                  future: FirestoreInforUser.getUserModel(),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                      default:
                        UserModel user = snapshot.data;
                        return TabBarView(
                          children: [
                            _buildTap1(user),
                            _buildTap2(user),
                          ],
                        );
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTap2(UserModel user) {
    var storeDetailRepeat = store.collection('dangvieclam').document(user.id).snapshots();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 231,
      child: StreamBuilder(
          stream: storeDetailRepeat,
          builder: (context, snapshot){
            List<dynamic> listJob = [];
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              default:
                DocumentSnapshot documentSnapshot = snapshot.data;
                if(documentSnapshot.data != null && snapshot.data['list_repeat'] != null){
                  listJob.clear();
                  listJob  = snapshot.data['list_repeat'];
                  return listJob.length != 0 ? ListView(
                    children: listJob.map((idDetail){
                      return showRepeat(idDetail, user.id);
                    }).toList(),
                  ): Center(child: Text('Không có công việc'),) ;}else{
                  return Center(child: Text('Không có công việc'),);
                }
            }
          }),
    );

  }

  Widget _buildTap1(UserModel user) {
    var storeDetail = store.collection('dangvieclam').document(user.id).snapshots();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 231,
      child: StreamBuilder(
          stream: storeDetail,
          builder: (context, snapshot){
            List<dynamic> listJob = [];
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              default:
                DocumentSnapshot documentSnapshot = snapshot.data;
                if(documentSnapshot.data != null){
                  listJob.clear();
                  listJob = snapshot.data['list_work'];
                  return (listJob !=  null && listJob.length != 0) ?
                  ListView.builder(
                      itemCount: listJob.length,
                      itemBuilder: (context, index){
                        return showJob(listJob[(listJob.length -1 )- index], user);
                      })
                      : Center(child: Text('Không có công việc', style: TextStyle(color: BLACK),),);
                }else{
                  return Center(child: Text('Không có công việc', style: TextStyle(color: BLACK),),);
                }

            }
          }),
    );
  }

  Widget showJob(String idDetail, UserModel user) {
    DetailPutService detail;
    var storeDetail = store.collection('chitietcongviec').document(idDetail).snapshots();
    return StreamBuilder(
        stream: storeDetail,
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              String idDV = snapshot.data['id'];
              if (idDV == 'DV01') {
                detail = ModelService1().fromMap(snapshot);
              } else if (idDV == 'DV02') {
                detail = ModelService2().fromMap(snapshot);
              } else if (idDV == 'DV03') {
                detail = ModelService3().fromMap(snapshot);
              } else if (idDV == 'DV04') {
                detail = ModelService4().fromMap(snapshot);
              }
              return FormPostWait(detail, user.id);
          }
        });
  }

  Widget showRepeat(String idDetailRepeat, String idCustomer) {
    String keyService = idDetailRepeat;
    DetailPutService detail;
    var storeDetailRepeat = store.collection('chitietcongviec').document(keyService).snapshots();
    return StreamBuilder(
        stream: storeDetailRepeat,
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              String idDV = snapshot.data['id'];
              if (idDV == 'DV01') {
                detail = ModelService1().fromMap(snapshot);
              }
              if (detail != null) {
                return FormRepeat(detail, idCustomer);
              } else {
                return SizedBox();
              }
          }
        });

  }

  @override
  bool get wantKeepAlive => true;
}
