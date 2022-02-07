import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/notification_model.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/get_store.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/notification_store.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/update_store.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/date_time_picker.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';
import 'package:sample_one/src/utils/form_page.dart';
import 'package:sample_one/src/utils/strings.dart';

class UpdateWorkScreen extends StatefulWidget {
  final DetailPutService detailPutService;
  final ServiceModel serviceModel;

  UpdateWorkScreen(this.detailPutService, this.serviceModel);
  @override
  _UpdateWorkScreenState createState() => _UpdateWorkScreenState();
}

class _UpdateWorkScreenState extends State<UpdateWorkScreen> {
  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.5,
      inAsyncCall: _isInAsyncCall,
      progressIndicator: CircularProgressIndicator(),
      child: FormPage(
        textBar: thayDoiNgayGio,
        content: Provider<PaymentBloc>(
            create: (_) => PaymentBloc(), child: content()),
      ),
    );
  }

  Widget content() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _widgetNameService(),
          SizedBox(
            height: 10,
          ),
          Expanded(child: _lineDetail()),
          _buttonUpdate()
        ],
      ),
    );
  }

  Widget _widgetNameService() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 20.0),
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: white,
            child: Image.asset(
              widget.serviceModel.imageService,
              color: orangeBackground,
              width: 50,
              height: 50,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.serviceModel.nameService,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Đăng lúc: ${widget.detailPutService.putByTime}',
                style: TextStyle(color: grey),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _lineDetail() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                    "Số nhà/ Căn hộ",
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
                  child: Text(
                      '${widget.detailPutService.apartment.typeHome} , ${widget.detailPutService.weightWork.idItem}',
                      style: TextStyle(fontSize: 16)),
                  flex: 2,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Ngày giờ làm việc mới'.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(color: grey),
          ),
          Container(
            height: 1.0,
            color: grey1,
            margin: EdgeInsets.only(bottom: 10.0, top: 2.0),
          ),
          WorkTime(widget.detailPutService,
              formatterHasHour.parse(widget.detailPutService.startTime)),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _buttonUpdate() {
    return Consumer<PaymentBloc>(
      builder: (context, bloc, child) => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: StreamBuilder<double>(
            stream: bloc.streamPayment,
            builder: (context, snapshot) {
              return RaisedButton(
                onPressed: snapshot.data == null
                    ? null
                    : () async {
                        setState(() {
                          _isInAsyncCall = true;
                        });
                        String timeStart =
                            '${widget.detailPutService.hour}, ${formatter.format(widget.detailPutService.day).toString()}';
                        var formatterTimeStart =
                            formatterHasHour.parse(timeStart);
                        if (!formatterTimeStart
                            .isAfter(DateTime.now().add(Duration(hours: 1)))) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      'Thời gian làm dịch vụ phải cách tầm 1 tiếng'),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Đóng'),
                                    )
                                  ],
                                );
                              });
                          setState(() {
                            _isInAsyncCall = false;
                          });
                        } else {
                          //update detail
                          String timeStart =
                              '${widget.detailPutService.hour}, ${formatter.format(widget.detailPutService.day).toString()}';
                          //print('oooooooooo----- ${widget.detailPutService.hour} ${widget.detailPutService.day} ${widget.detailPutService.startTime}');
                          UpdateStore.updateDetail(
                              widget.detailPutService.idDetail, timeStart);

                          var startTime = formatterHasHour
                              .parse(widget.detailPutService.startTime);

                          GetStore.getListIdPartnerOfJob(
                                  widget.detailPutService.idDetail)
                              .then((listIdPartner) {
                            listIdPartner.forEach((idPartner) {
                              UpdateStore.removeCalendar(
                                  idPartner,
                                  formatter1.format(startTime),
                                  widget.detailPutService.idDetail);
                              UpdateStore.removeNhanViec(
                                  idPartner, widget.detailPutService.idDetail);
                              NotificationStore.sendNotification(
                                  idPartner,
                                  NotificationModel('Công việc bị hủy',
                                      'Công việc vào ngày ${widget.detailPutService.startTime} khách hàng đã thay đổi thời gian'));
                            });
                            //remove nhanviec lich lam viec
                          });

                          Future.delayed(Duration(seconds: 3), () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text('Đã update xong'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/app',
                                                  (Route<dynamic> route) =>
                                                      false,
                                                  arguments: 1);
                                        },
                                        child: Text(
                                          'Tiếp tục',
                                          style: TextStyle(color: GREEN),
                                        ),
                                      )
                                    ],
                                  );
                                });
                            setState(() {
                              _isInAsyncCall = false;
                            });
                          });
                        }
                      },
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: GREEN,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      snapshot.data != null
                          ? '${oCcy.format(snapshot.data)} VND/${widget.detailPutService.weightWork.thoiGian} giờ'
                          : "${oCcy.format(widget.detailPutService.paymentMethod.money)} VND/${widget.detailPutService.weightWork.thoiGian} giờ",
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      'Cập nhật',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
