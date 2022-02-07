import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/notification_model.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/notification_store.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/update_store.dart';
import 'package:sample_one/src/my_firebase/firebase.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_posted/dialog_remove_service.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_posted/dialog_verification.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_posted/information_partner.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_posted/update_work_screen.dart';
import 'package:sample_one/src/resources/widgets/get_image_storage.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';
import 'package:sample_one/src/utils/images.dart';
import 'package:sample_one/src/utils/strings.dart';

class FormPostWait extends StatefulWidget {
  final DetailPutService detailPutService;
  final String idCustomer;
  FormPostWait(this.detailPutService, this.idCustomer);
  @override
  _FormPostWaitState createState() => _FormPostWaitState();
}

class _FormPostWaitState extends State<FormPostWait>
    with AutomaticKeepAliveClientMixin {
  ServiceModel serviceModel = ServiceModel.s1();

  @override
  void initState() {
    super.initState();
    if (widget.detailPutService.idService == 'DV01') {
      serviceModel = ServiceModel.s1();
    } else if (widget.detailPutService.idService == 'DV02') {
      serviceModel = ServiceModel.s2();
    } else if (widget.detailPutService.idService == 'DV03') {
      serviceModel = ServiceModel.s3();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: grey, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: _widgetNameService(),
          ),
          Container(
            height: 1.0,
            color: grey1,
            margin: EdgeInsets.only(bottom: 5.0, top: 2.0),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            //height: MediaQuery.of(context).size.height,
            child: _lineDetail(),
          ),
          Container(
            height: 1.0,
            color: grey1,
            margin: EdgeInsets.only(bottom: 5.0, top: 2.0),
          ),
          StreamBuilder(
              stream: store
                  .collection('nhanviec')
                  .where('list_work',
                      arrayContains: widget.detailPutService.idDetail)
                  .snapshots(),
              builder: (context, snapshotListIdPartner) {
                switch (snapshotListIdPartner.connectionState) {
                  case ConnectionState.waiting:
                    return _buildNoPartner();
                  case ConnectionState.active:
                    List<String> listIdPartner = [];
                    List<DocumentSnapshot> listData =
                        snapshotListIdPartner.data.documents;
                    listData.forEach((document) {
                      listIdPartner.add(document.documentID);
                    });
                    return _widgetCheckTime(listIdPartner);
                  default:
                    return _buildNoPartner();
                }
              }),
        ],
      ),
    );
  }

  Widget _widgetCheckTime(List<String> listIdPartner) {
    var startTime = formatterHasHour.parse(widget.detailPutService.startTime);
    //print('bbbbbbb ${startTime} -- ${startTime.isAfter(DateTime.now())}');
    if (!startTime.isAfter(DateTime.now())) {
      if (listIdPartner.length < 1) {
        return _buildNoPartnerGetJob();
      } else {
        return _buildPartner(listIdPartner);
      }
    } else {
      return _buildPartner(listIdPartner);
    }
  }

  Widget _buildNoPartnerGetJob() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 10),
      child: Column(
        children: [
          Text(
            'Đã quá thời gian nhưng không có hoặc không đủ người nhận công việc này. '
            'Bạn có muốn đổi thời gian khác hoặc hủy công việc này không?',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 13, color: red),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: RaisedButton(
                  color: GREEN,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => UpdateWorkScreen(
                              widget.detailPutService, serviceModel)));
                    },
                    child: Text(
                      'Đổi thời gian',
                      style: TextStyle(color: white),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: RaisedButton(
                  color: GREEN,
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return DialogReasonRemove(
                                widget.idCustomer,
                                widget.detailPutService,
                                );
                          });
                    },
                    child: Text(
                      'Hủy công việc',
                      style: TextStyle(color: white),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNoPartner() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 10),
      child: Text(
        'HỆ THỐNG SẼ CHỌN NGƯỜI NHẬN VIỆC ĐẦU TIÊN\nChưa có ai nhận việc',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: BLACK),
      ),
    );
  }

  Widget _buildPartner(List<String> listIdPartner) {
    if (listIdPartner != null && listIdPartner.length != 0) {
      return Container(
        child: Column(
          children: [
            Text(
              'NGƯỜI THỰC HIỆN CÔNG VIỆC',
              style: TextStyle(fontSize: 13, color: grey),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: listIdPartner.map((idPartner) {
                return StreamBuilder(
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
                          return Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      DocumentSnapshot ds = snapshot.data;
                                      UserModel partner =
                                          UserModel.fromMap(ds.data, idPartner);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  InformationPartner(partner)));
                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(40),
                                          boxShadow: [
                                            BoxShadow(
                                              color: grey,
                                              blurRadius: 0.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(0.0, 0.0), // shadow direction: bottom right
                                            )
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 40.0,
                                          child: ClipOval(
                                            child: SizedBox(
                                              width: 80.0,
                                              height: 80.0,
                                              child:
                                                  snapshot.data['image'] != null
                                                      ? GetImageAvtStorage(
                                                          snapshot.data['image'])
                                                      : Image.asset(
                                                          imageAvatar,
                                                          fit: BoxFit.fill,
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${snapshot.data['name']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      FutureBuilder(
                                          future: Evaluate.avgStar(
                                              idPartner),
                                          builder: (context, snapStar) {
                                            switch (snapStar
                                                .connectionState) {
                                              case ConnectionState
                                                  .waiting:
                                                return Icon(
                                                  Icons.star,
                                                  color: orangeBackground,
                                                );
                                              case ConnectionState.done:
                                                double star = 0;
                                                if (!snapStar
                                                    .data.isNaN) {
                                                  star = snapStar.data;
                                                }
                                                return Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.star,
                                                      color: orangeBackground,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${star.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: grey,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                );
                                              default:
                                                return Center(
                                                    child: Icon(
                                                      Icons.star_border,
                                                      color: orangeBackground,
                                                    ));
                                            }
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              child: _dialogDetelePartner(
                                                  idPartner));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Không nhận người làm này',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: white)),
                                          ],
                                        ),
                                        color: GREEN,
                                      ),
                                    ],
                                  )),
                            ],
                          );
                      }
                    });
              }).toList(),
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return DialogVerification(
                          widget.idCustomer,
                          widget.detailPutService,
                          widget.detailPutService.startTime,
                          listIdPartner);
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Xác nhận người làm',
                      style: TextStyle(fontSize: 13, color: white)),
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    iconQrCode,
                    color: white,
                  )
                ],
              ),
              color: GREEN,
            ),
          ],
        ),
      );
    } else {
      return _buildNoPartner();
    }
  }

  Widget _widgetNameService() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: white,
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => UpdateWorkScreen(
                          widget.detailPutService, serviceModel)));
                } else if (value == 2) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return DialogReasonRemove(
                            widget.idCustomer,
                            widget.detailPutService);
                      });
                }
              },
              itemBuilder: (BuildContext context) {
                int index = 0;
                return listPopupWait.map((String choice) {
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
                  "Ngày giờ làm",
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
                  "Số nhà/Căn hộ",
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
                    color: grey,
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
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Giá tiền",
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
                    '${oCcy.format(widget.detailPutService.paymentMethod.money)} VND',
                    style: TextStyle(fontSize: 16)),
                flex: 2,
              ),
            ],
          ),
        ),
        //tip
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
        //them dich vu
        widget.detailPutService is ModelService1
            ? daBaoGom(widget.detailPutService)
            : SizedBox(),
        //ghi chu
        (widget.detailPutService.note != null &&
                widget.detailPutService.note != '')
            ? Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        ghiChu,
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
    if (modelService1.mop) baoGom += "Đem theo dụng cụ";

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

  Widget _dialogDetelePartner(String idPartner) {
    return AlertDialog(
      content: Text('Bạn chắc chắn không nhận người làm này?'),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Đóng',
              style: TextStyle(color: BLACK),
            )),
        FlatButton(
            onPressed: () {
              var startTime =
                  formatterHasHour.parse(widget.detailPutService.startTime);
              UpdateStore.removeCalendar(
                  idPartner,
                  formatter1.format(startTime),
                  widget.detailPutService.idDetail);
              UpdateStore.removeNhanViec(
                  idPartner, widget.detailPutService.idDetail);
              NotificationStore.sendNotification(
                  idPartner,
                  NotificationModel(
                      'Công việc hủy', 'Khách hàng đã không nhận bạn vào làm'));
              Navigator.of(context).pop();
            },
            child: Text(
              'Chắc chắn',
              style: TextStyle(color: GREEN),
            )),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
