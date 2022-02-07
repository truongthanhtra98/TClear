import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/add_store.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/get_store.dart';
import 'package:sample_one/src/resources/widgets/get_image_storage.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/strings.dart';

class ScreenDangViec extends StatefulWidget {

  @override
  _ScreenDangViecState createState() => _ScreenDangViecState();
}

class _ScreenDangViecState extends State<ScreenDangViec> with AutomaticKeepAliveClientMixin{
  List<ServiceModel> listService = [];

  void getListService(AsyncSnapshot snapshot){
    snapshot.data.documents.map((document){
      listService.add(ServiceModel.fromJson(document.documentID, document));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
        height: MediaQuery.of(context).size.height - 177.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
        ),
        child: FutureBuilder(
            future: GetStore.getListService(),
            builder: (context, snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(),);
                default:
                  listService.clear();
                  getListService(snapshot);
                  listService.sort((a, b) => a.idService.compareTo(b.idService));
                  return ListView(
                    children: getJobCategories(),
                  );
              }
            })
    );
  }

  List<Widget> getJobCategories() {
    List<Widget> jobCategoriesCards = [];
    List<Widget> rows = [];
    int i = 0;
    for (ServiceModel service in listService) {
      if (i < 2) {
        rows.add(GetServiceItem(service));
        i++;
      } else {
        i = 0;
        jobCategoriesCards.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ));
        rows = [];
        rows.add(GetServiceItem(service));
        i++;
      }
    }
    if (rows.length > 0) {
      jobCategoriesCards.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ));
    }
    return jobCategoriesCards;
  }

  @override
  bool get wantKeepAlive => true;

}

class GetServiceItem extends StatefulWidget {
  ServiceModel service;
  GetServiceItem(this.service);

  @override
  _GetServiceItemState createState() => _GetServiceItemState();
}

class _GetServiceItemState extends State<GetServiceItem> {

  var _textThemDichvu = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5, bottom: 10),
      height: (MediaQuery.of(context).size.height - 177.0)/2 - 10,
      width: (MediaQuery.of(context).size.width/2) - 20,
      //padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          new BoxShadow(
            color: white,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: FlatButton(
        onPressed: (){
          if(widget.service.idService != 'final'){
            onClickService(widget.service, context);
          }else{
            showDialog(context: context,
                child: AlertDialog(
                  title: Text('Thêm dịch vụ'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Bạn cần TClear bổ sung dịch vụ nào trong tương lai? (*)'),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: _textThemDichvu,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: grey1)),
                        ),

                      ),
                    ],
                  ),
                  actions: [
                    FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text(dong, style: TextStyle(color: BLACK,))),
                    FlatButton(onPressed: (){
                      String content = _textThemDichvu.text;
                      _textThemDichvu.clear();
                      AddStore.addFinal(content);
                      Navigator.of(context).pop();
                      showDialog(context: context, child: AlertDialog(
                        content: Text('Cảm ơn bạn đã gửi yêu cầu đến TClear!\nChúng tôi sẽ thống kê và sớm đưa vào dịch vụ có nhiều người yêu cầu nhất.'),
                        actions: [
                          FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text(dong, style: TextStyle(color: BLACK),))
                        ],
                      ));
                    }, child: Text(dongY, style: TextStyle(color: GREEN,))),
                  ],
                ));
          }
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                //radius: 50,
                backgroundColor: white,
                foregroundColor: orangeBackground,
                child: widget.service.idService != 'final' ? GetImageStorage(widget.service.imageService) : Icon(Icons.add_circle_outline, color: GREEN, size: 50,),
              ),
            ),
            Text(
              widget.service.nameService,
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void onClickService(ServiceModel serviceModel, BuildContext context) {
    Navigator.of(context).pushNamed(serviceModel.page, arguments: serviceModel);
  }

  @override
  void dispose() {
    super.dispose();
    _textThemDichvu.dispose();
  }
}

