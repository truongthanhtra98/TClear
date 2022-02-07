import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_2.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_4.dart';
import 'package:sample_one/src/data_models/history_model.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/get_store.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/utils/colors.dart';

import 'tab_history/form_history.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
      //padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 50),
              color: Colors.white,
              child: TabBar(
                  isScrollable: false,
                  labelColor: Colors.green,
                  indicatorColor: Colors.green,
                  unselectedLabelColor: grey,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: "Đã làm"),
                    Tab(text: "Đã hủy"),
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
                          _daLam(user),
                          _daHuy(user),
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

  Widget test(){
    return Container(
        child: StreamBuilder<List>(
            stream: GetStore.thongke(),
            builder: (context, snapshot){
              return Text('abc');
    }));
  }

  Widget _daHuy(UserModel user){
    return Container(
      child: StreamBuilder<List>(
          stream: GetStore.getHistoryCancel(user.id),
          builder: (context, snapshot){
            List<dynamic> listHistory = [];
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.none:
                return Center(child: Text('Không có lịch sử'),);
              default:
                if(snapshot.data != null){
                  listHistory.clear();
                  listHistory = snapshot.data;
                  return (listHistory != null && listHistory.length != 0) ?
                  ListView.builder(
                      itemCount: listHistory.length,
                      itemBuilder: (context, index){
                        Map mapHistory = listHistory[(listHistory.length -1) - index];
                        return showHistory(mapHistory);
                      })
                      : Center(child: Text('Không có lịch sử'),);
                }else{
                  return Center(child: Text('Không có lịch sử'),);
                }
            }
          }),
    );
  }

  Widget _daLam(UserModel user){
    return Container(
      child: StreamBuilder<List>(
          stream: GetStore.getHistoryDone(user.id),
          builder: (context, snapshot){
            List<dynamic> listHistory = [];
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.none:
                return Center(child: Text('Không có lịch sử đã làm'),);
              default:

                if(snapshot.data != null){
                  listHistory.clear();
                  listHistory = snapshot.data;
                  return (listHistory != null && listHistory.length != 0) ?
                  ListView.builder(
                      itemCount: listHistory.length,
                      itemBuilder: (context, index){
                        Map mapHistory = listHistory[(listHistory.length -1) - index];
                        return showHistory(mapHistory);
                      })
                      : Center(child: Text('Không có lịch sử đã làm'),);
                }else{
                  return Center(child: Text('Không có lịch sử đã làm'),);
                }
            }
          }),
    );
  }

  Widget showHistory(Map map) {
    String idDetail = map['idDetail'];
    HistoryModel historyModel = HistoryModel.fromHistory(map);
    DetailPutService detail;
    var storeDetail = store.collection('chitietcongviec').document(idDetail).snapshots();
    return StreamBuilder(
      stream: storeDetail,
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              if(snapshot.data != null){
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
                return FormHistory(detail, historyModel);
              }else{
                return Center(child: Text('Không có lịch sử đã làm'),);
              }

          }
    });
  
  }

  @override
  bool get wantKeepAlive => true;
}
