
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/history_model.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_history/dialog_evaluate.dart';
import 'package:sample_one/src/resources/widgets/get_image_storage.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';
import 'package:sample_one/src/utils/strings.dart';

class FormHistory extends StatefulWidget{
  final DetailPutService detailPutService;
  final HistoryModel historyModel;

  FormHistory(this.detailPutService, this.historyModel);
  @override
  _FormHistoryState createState() => _FormHistoryState();
}

class _FormHistoryState extends State<FormHistory> with AutomaticKeepAliveClientMixin{

  ServiceModel serviceModel;

  @override
  void initState() {
    super.initState();
    if(widget.detailPutService.idService == 'DV01'){
      serviceModel = ServiceModel.s1();
    }else if(widget.detailPutService.idService == 'DV02'){
      serviceModel = ServiceModel.s2();
    }else if(widget.detailPutService.idService == 'DV03'){
      serviceModel = ServiceModel.s2();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF929292), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: _widgetNameService(),
          ),
          Container(height: 1.0, color: Colors.black26, margin: EdgeInsets.only(bottom: 5.0, top: 2.0),),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            //height: MediaQuery.of(context).size.height,
            child:_lineDetail(),
          ),
          Container(height: 1.0, color: Colors.black26, margin: EdgeInsets.only(bottom: 5.0, top: 2.0),),
          _buildPartner(),
        ],
      ),
    );
  }

  Widget _widgetNameService(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Image.asset(
                serviceModel.imageService,
                color: Colors.deepOrangeAccent,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),

        Expanded(child: Center(child: Text(serviceModel.nameService, style: TextStyle(fontSize: 18.0),)),),


        Expanded(child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${widget.historyModel.status}', style: TextStyle(color: Colors.red),)
          ],
        )),
      ],
    );
  }

  Widget _lineDetail(){
    return Column(
      children: <Widget>[
        //ngay bat dau
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("NGÀY LÀM", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
              SizedBox(width: 10,),
              Expanded(child: Text('${widget.historyModel.timeStart}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),), flex: 2,),
            ],
          ),
        ),
        //dia chi
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("ĐỊA CHỈ", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),SizedBox(width: 10,),
              Expanded(child: Text('${widget.detailPutService.locationWork.formattedAddress}', style: TextStyle(fontSize: 16),), flex: 2,),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("GIÁ TIỀN", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),SizedBox(width: 10,),
              Expanded(child: Text('${oCcy.format(double.parse(widget.historyModel.money))} VND', style: TextStyle(fontSize: 16),), flex: 2,),
            ],
          ),
        ),
        //so nha
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("VÀO LÚC", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),SizedBox(width: 10,),
              Expanded(child: Text('${widget.historyModel.timeCancel.toString()}', style: TextStyle(fontSize: 16)), flex: 2,),
            ],
          ),
        ),
        //loai nha
        widget.historyModel.reason != null? Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("LÝ DO", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),SizedBox(width: 10,),
              Expanded(child: Text('${widget.historyModel.reason}', style: TextStyle(fontSize: 16)), flex: 2,),
            ],
          ),
        ) : SizedBox(),

      ],
    );
  }

  Widget _buildPartner() {
    String idEvalue = (widget.historyModel.idDetail + formatterHasHour.parse(
        widget.historyModel.timeStart).toString());
    print(idEvalue);
    return widget.historyModel.status == daXong?
        StreamBuilder(
          stream: store.collection('danhgia').document(idEvalue).snapshots(),
          builder: (context, snapEvaluate) {
            switch(snapEvaluate.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              default:
                List listIdPartner = snapEvaluate.data['idPartner'];
                int star = snapEvaluate.data['star'];
                return Container(
                  padding: EdgeInsets.only(bottom: 5, top: 10),
                  child: Column(
                    children: [
                      Text(
                        'NGƯỜI THỰC HIỆN CÔNG VIỆC',
                        style: TextStyle(fontSize: 13, color: grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: listIdPartner.map((idPartner){
                          return Expanded(
                            child: StreamBuilder(
                                stream: store
                                    .collection('userpartners')
                                    .document(idPartner)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    default:
                                      return Container(
                                        height: 100,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Center(
                                                  child: CircleAvatar(
                                                    radius: 35.0,
                                                    child: ClipOval(
                                                      child: SizedBox(
                                                        width: 70.0,
                                                        height: 70.0,
                                                        child: snapshot.data['image'] != null?
                                                        GetImageAvtStorage(snapshot.data['image']) :
                                                        Image.asset('assets/images/avatar.jpg', fit: BoxFit.fill,),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(height: 10,),
                                            Text('${snapshot.data['name']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                                ), overflow: TextOverflow.clip,),
                                          ],
                                        ),
                                      );
                                  }
                                }),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10,),
                      star !=0?
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Đánh giá của bạn: ', style: TextStyle(fontWeight: FontWeight.w500),),
                                star > 0 ?  Icon(Icons.star, color: orangeBackground,): Icon(Icons.star_border,),
                                star > 1 ?  Icon(Icons.star, color: orangeBackground,): Icon(Icons.star_border,),
                                star > 2 ?  Icon(Icons.star, color: orangeBackground,): Icon(Icons.star_border,),
                                star > 3 ?  Icon(Icons.star, color: orangeBackground,): Icon(Icons.star_border,),
                                star > 4 ?  Icon(Icons.star, color: orangeBackground,): Icon(Icons.star_border,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            snapEvaluate.data['comment'] != ''?
                            RichText(text: TextSpan(
                              text: 'Lý do đánh giá: ',
                              style: TextStyle(fontWeight: FontWeight.w500, color: BLACK),
                              children: [
                                TextSpan(
                                  text: '${snapEvaluate.data['comment']}',
                                  style: TextStyle(fontWeight: FontWeight.normal, color: BLACK)
                                )
                              ]
                            )): SizedBox()
                          ],
                        ),
                      ):
                      RaisedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              //barrierDismissible: false,
                              builder: (BuildContext context) {
                                return  DialogEvaluate(idEvalue);
                              });
                        },
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Đánh giá',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: white)),
                          ],
                        ),
                        color: GREEN,
                      )
                    ],
                  ),
                );
            }

          }
        ):SizedBox();

  }

  @override
  bool get wantKeepAlive => true;

}
