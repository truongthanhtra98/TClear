import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/payment_method.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/resources/payment/xac_nhan_thong_tin.dart';
import 'package:sample_one/src/resources/widgets/email_text_field.dart';
import 'package:sample_one/src/resources/widgets/name_text_field.dart';
import 'package:sample_one/src/resources/widgets/phone_number_text_field.dart';
import 'package:sample_one/src/utils/data_holder.dart';
import 'package:sample_one/src/utils/form_page.dart';
import 'package:sample_one/src/utils/strings.dart';

class LienHeVaThanhToan extends StatefulWidget {
  final DetailPutService detailPutService;
  final ServiceModel serviceModel;
  final double money;
  LienHeVaThanhToan(this.detailPutService, this.serviceModel, this.money);

  @override
  _LienHeVaThanhToanState createState() => _LienHeVaThanhToanState();
}

class _LienHeVaThanhToanState extends State<LienHeVaThanhToan> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  UserModel userModel;
  @override
  void initState() {
    super.initState();
    FirestoreInforUser.getUserModel().then((user) {
      if (user != null) {
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
        userModel = user;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormPage(
      textBar: "Liên hệ và thanh toán",
      content: _content(),
    );
  }

  Widget _content() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'THÔNG TIN LIÊN HỆ',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              NameTextField(
                nameController: _nameController,
              ),
              PhoneNumberTextField(
                phoneController: _phoneController,
              ),
              EmailTextField(
                emailController: _emailController,
              ),
              _thanhToan(),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: _buttonNext(),
        ),
      ],
    );
  }

  var _value = '1';
  String _method= "Tiền mặt";
  Widget _thanhToan() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'THANH TOÁN',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        Container(
          height: 40.0,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: DropdownButton<String>(
              items: PaymentMethod.listMethod().map((method) {
                return DropdownMenuItem(
                  value: method.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${method.method}'),
                    ],
                  ),
                );
              }).toList(),
             
              onChanged: (value) {
                setState(() {
                  _value = value;
                  if(_value == '1'){
                    _method = 'Tiền mặt';
                  }if(_value == '2'){
                    _method = "Ví Momo";
                  }if(_value == '3'){
                    _method = "Chuyển khoản";
                  }
                });
              },
              value: _value,
              isExpanded: true,
              underline: Container(
                height: 0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonNext() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(color: Colors.green, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: RaisedButton(
        onPressed: () {
          userModel.name = _nameController.text;
          userModel.phone = _phoneController.text;
          userModel.email = _emailController.text;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => XacNhanThongTin(
                    detailPutService: widget.detailPutService,
                    userModel: userModel,
                    serviceModel: widget.serviceModel,
                    paymentMethod: PaymentMethod(_value, _method, money: widget.money),
                  )));
        },
        padding: EdgeInsets.all(9.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${oCcy.format(widget.money)} VND",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            Spacer(),
            Text(
              tiepTheo,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.0,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans',
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
