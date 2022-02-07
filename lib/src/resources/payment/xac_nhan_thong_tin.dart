import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/payment_method.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/add_store.dart';
import 'package:sample_one/src/resources/payment/widgets_xntt/chi_tiet_cong_viec.dart';
import 'package:sample_one/src/resources/widgets/get_image_storage.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';
import 'package:sample_one/src/utils/form_page.dart';

class XacNhanThongTin extends StatefulWidget {
  final DetailPutService detailPutService;
  final UserModel userModel;
  final ServiceModel serviceModel;
  final PaymentMethod paymentMethod;
  XacNhanThongTin({this.detailPutService, this.userModel, this.serviceModel, this.paymentMethod});

  @override
  _XacNhanThongTinState createState() => _XacNhanThongTinState();
}

class _XacNhanThongTinState extends State<XacNhanThongTin> {
  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(opacity: 0.5,
        inAsyncCall: _isInAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        child: FormPage(textBar: "Xác nhận thông tin", content: _content(),));
  }

  Widget _content(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: _widgetNameService(),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: _listInfor(),
            ),
          ),

          //Spacer(),
          _buildButtonAccept(),

        ],
      ),
    );
  }

  Widget _widgetNameService(){
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.white,
              child: GetImageStorage(widget.serviceModel.imageService)
          ),
        ),
        Text(widget.serviceModel.nameService, style: TextStyle(fontSize: 18.0),),
      ],
    );
  }

  Widget _listInfor(){
    return ListView(
      children: <Widget>[
        Text('CHI TIẾT CÔNG VIỆC', style: TextStyle(color: grey,),),
        Container(height: 1.0, color: grey, margin: EdgeInsets.only(bottom: 5.0, top: 2.0),),
        ChiTietCongViec(widget.detailPutService),
        SizedBox(height: 15.0,),
        Text('THÔNG TIN LIÊN THỆ', style: TextStyle(color: grey),),
        Container(height: 1.0, color: grey, margin: EdgeInsets.only(bottom: 5.0, top: 5.0),),
        _infor(),
        SizedBox(height: 15.0,),
        Text('THANH TOÁN', style: TextStyle(color: grey),),
        Container(height: 1.0, color: grey, margin: EdgeInsets.only(bottom: 5.0, top: 5.0),),
        _payment(),
        SizedBox(height: 15.0,),
        Text('TIP', style: TextStyle(color: grey),),
        Container(height: 1.0, color: grey, margin: EdgeInsets.only(bottom: 5.0, top: 5.0),),
        _tip(),
      ],
    );
  }

  Widget _infor(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Họ và tên", style: TextStyle(color: grey,),), flex: 1,),
              Expanded(child: Text("${widget.userModel.name}"), flex: 2,),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Số điện thoại", style: TextStyle(color: grey,),), flex: 1,),
              Expanded(child: Text("${widget.userModel.phone}"), flex: 2,),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Email", style: TextStyle(color: grey,),), flex: 1,),
              Expanded(child: Text("${widget.userModel.email}"), flex: 2,),
            ],
          ),
        ),
      ],
    );
  }

  int tip = 0;
  Widget _payment(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Tiền dịch vụ", style: TextStyle(color: grey,),), flex: 1,),
              Expanded(child: Text("${oCcy.format(widget.paymentMethod.money)} VNĐ"), flex: 2,),
            ],
          ),
        ),
        tip != 0 ? Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Tiền TIP", style: TextStyle(color: grey,),), flex: 1,),
              Expanded(child: Text("${oCcy.format(tip)} VND"), flex: 2,),
            ],
          ),
        ) : SizedBox(),

        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Phương thức thanh toán", style: TextStyle(color: grey,),), flex: 1,),
              Expanded(child: Text("${widget.paymentMethod.method}"), flex: 2,),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Tổng số tiền thanh toán", style: TextStyle(color: grey,),), flex: 1,),
              Expanded(child: Text("${oCcy.format(widget.paymentMethod.money + tip)} VND"), flex: 2,),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tip(){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text("Phụ cấp thêm để kiếm được người làm nhanh hơn"),),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: IconButton(icon: Icon(Icons.remove_circle_outline), color: GREEN,onPressed: tip != 0 ? (){
                setState(() {
                  tip += -10000;
                });
              } : null,)),
              Expanded(child: IconButton(icon: Icon(Icons.add_circle_outline), color: GREEN,onPressed: (){
                setState(() {
                  tip += 10000;
                });
              },)),
            ],
          ),),
      ],
    );
  }

  Widget _buildButtonAccept() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: GREEN,
        border: Border.all(color: GREEN, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: RaisedButton(
        elevation: 3.0,
        onPressed: () {
          setState(() {
            _isInAsyncCall = true;
          });
          widget.detailPutService.paymentMethod =widget.paymentMethod;
          widget.detailPutService.tip = tip;
          //set contact
          widget.detailPutService.contactUser = widget.userModel;
          Future.delayed(Duration(seconds: 3), (){
            AddStore.addDatDichVu(widget.userModel, widget.detailPutService);
            setState(() {
              _isInAsyncCall = false;
            });
            Navigator.of(context).pushNamedAndRemoveUntil('/app', (Route<dynamic> route) => false, arguments: 1);
          });
          //end
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: GREEN,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Xác nhận thông tin',
              style: TextStyle(
                color: white,
                letterSpacing: 0.0,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(width: 10,),
            Icon(Icons.arrow_forward, color: white, size: 32.0,),
          ],
        ),
      ),
    );
  }
}
