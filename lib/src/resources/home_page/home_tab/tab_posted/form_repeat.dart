import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/remove_service.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';

class FormRepeat extends StatefulWidget {
  final DetailPutService detailPutService;
  final String idCustomer;
  FormRepeat(this.detailPutService, this.idCustomer);
  @override
  _FormRepeatState createState() => _FormRepeatState();
}

class _FormRepeatState extends State<FormRepeat>
    with AutomaticKeepAliveClientMixin {
  ServiceModel serviceModel = ServiceModel.s1();

  @override
  void initState() {
    super.initState();
    if (widget.detailPutService.idService == 'DV01') {
      serviceModel = ServiceModel.s1();
    } else if (widget.detailPutService.idService == 'DV02') {
      serviceModel = ServiceModel.s2();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: Color(0xFF929292), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: _widgetNameService(),
          ),
          Container(
            height: 1.0,
            color: Colors.black26,
            margin: EdgeInsets.only(bottom: 5.0, top: 2.0),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            //height: MediaQuery.of(context).size.height,
            child: _lineDetail(),
          ),
          Container(
            height: 1.0,
            color: Colors.black26,
            margin: EdgeInsets.only(bottom: 5.0, top: 2.0),
          ),
        ],
      ),
    );
  }

  Widget _widgetNameService() {
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
                color: orangeBackground,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
              child: Text(
                serviceModel.nameService,
                style: TextStyle(fontSize: 18.0),
              )),
        ),
        Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PopupMenuButton(
                  elevation: 3.2,
                  onCanceled: () {
                    print('You have not chossed anything');
                  },
                  tooltip: 'This is tooltip',
                  onSelected: (value) {
                    if (value == 1) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  'Bạn chắc chắn muốn xóa lịch làm việc này chứ?'),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Đóng',
                                      style: TextStyle(
                                          color: BLACK,
                                          fontWeight: FontWeight.w600),
                                    )),
                                FlatButton(
                                    onPressed: () {
                                      RemoveService.removeRepeat(widget.idCustomer,
                                          widget.detailPutService.idDetail);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Xóa',
                                      style: TextStyle(
                                          color: GREEN,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            );
                          });
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    int index = 0;
                    return listPopupRepeat.map((String choice) {
                      index++;
                      return PopupMenuItem(
                        value: index,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            )),
      ],
    );
  }

  Widget _lineDetail() {
    return Column(
      children: <Widget>[
        //ngay bat dau
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Ngày bắt đầu",
                  style: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  '${widget.detailPutService.startTime}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
        //dia chi
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Địa chỉ",
                  style: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  '${widget.detailPutService.locationWork.formattedAddress}',
                  style: TextStyle(fontSize: 16),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
        //so nha
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Số nhà/ Căn hộ",
                  style: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                    '${widget.detailPutService.apartment.apartmentNumber}',
                    style: TextStyle(fontSize: 16)),
                flex: 2,
              ),
            ],
          ),
        ),
        //loai nha
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Loại nhà",
                  style: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text('${widget.detailPutService.apartment.typeHome}',
                    style: TextStyle(fontSize: 16)),
                flex: 2,
              ),
            ],
          ),
        ),
        //gia tien
        //them dich vu
        widget.detailPutService is ModelService1
            ? daBaoGom(widget.detailPutService)
            : SizedBox(),
        //ghi chu

        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Ngày lặp lại",
                  style: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        
        (widget.detailPutService.tip != null &&
            widget.detailPutService.tip != 0)
            ? Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Tiền TIP",
                  style: TextStyle(
                    color: grey,
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                    '${oCcy.format(widget.detailPutService.tip)} VND',
                    style: TextStyle(fontSize: 16)),
                flex: 2,
              ),
            ],
          ),
        )
            : SizedBox(),

        _ngaylaplai(),

        widget.detailPutService.note != null
            ? Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Ghi chú",
                  style: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text('${widget.detailPutService.note}',
                    style: TextStyle(fontSize: 16)),
                flex: 2,
              ),
            ],
          ),
        )
            : SizedBox(),
      ],
    );
  }

  Widget daBaoGom(ModelService1 modelService1) {
    String baoGom = "";
    if (modelService1.iron) baoGom += "Ủi đồ - ";
    if (modelService1.cooking) baoGom += "Nấu ăn - ";
    if (modelService1.mop) baoGom += " Đem theo dụng cụ";

    if (baoGom != "") {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Đã bao gồm",
                style: TextStyle(
                  color: grey,
                ),
              ),
              flex: 1,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "$baoGom",
                style: TextStyle(color: GREEN),
              ),
              flex: 2,
            ),
          ],
        ),
      );
    }

    return SizedBox();
  }

  Widget _ngaylaplai() {
    var storeRepeat = store
        .collection('chitietcongviec')
        .document(widget.detailPutService.idDetail)
        .snapshots();
    return StreamBuilder(
        stream: storeRepeat,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFF1F1F1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'CN',
                        style: TextStyle(
                            color: snapshot.data['ngaylaplai']['CN']
                                ? Colors.green
                                : Colors.black45,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'T2',
                        style: TextStyle(
                            color: snapshot.data['ngaylaplai']['T2']
                                ? Colors.green
                                : Colors.black45,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'T3',
                        style: TextStyle(
                            color: snapshot.data['ngaylaplai']['T3']
                                ? Colors.green
                                : Colors.black45,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'T4',
                        style: TextStyle(
                            color: snapshot.data['ngaylaplai']['T4']
                                ? Colors.green
                                : Colors.black45,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'T5',
                        style: TextStyle(
                            color: snapshot.data['ngaylaplai']['T5']
                                ? Colors.green
                                : Colors.black45,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'T6',
                        style: TextStyle(
                            color: snapshot.data['ngaylaplai']['T6']
                                ? Colors.green
                                : Colors.black45,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'T7',
                        style: TextStyle(
                            color: snapshot.data['ngaylaplai']['T7']
                                ? Colors.green
                                : Colors.black45,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
