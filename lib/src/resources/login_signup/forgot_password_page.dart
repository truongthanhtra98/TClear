import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sample_one/src/bloc/forgot_password_bloc.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/resources/login_signup/otp_screen.dart';
import 'package:sample_one/src/resources/widgets/phone_number_text_field.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/cover_phone.dart';
import 'package:sample_one/src/utils/form_page.dart';
import 'package:sample_one/src/utils/strings.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();
  var _textNumberPhoneController = TextEditingController();

  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;

  Widget _buildEnterPhoneTxt(){
    return Center(
      child: Text(
        'Nhập số điện thoại đã đăng ký để nhận lại mật khẩu của bạn',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildIdeaPassBtn() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _textNumberPhoneController.value != null ? onClickSendPassword : null,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: GREEN,
        child: Text(
          guiLaiMatKhau,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.0,
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.5,
      inAsyncCall: _isInAsyncCall,
      progressIndicator: CircularProgressIndicator(),
      child: FormPage(
        textBar: quenMatKhau,
        content: _getContent(),
      ),
    );
  }

  Widget _getContent(){
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 5.0,),
          _buildEnterPhoneTxt(),
          SizedBox(height: 20.0,),
          PhoneNumberTextField(phoneController: _textNumberPhoneController, stream: _forgotPasswordBloc.phoneForgotStream,),
          SizedBox(height: 15.0,),
          _buildIdeaPassBtn(),
        ],
      ),
    );
  }

  void onClickSendPassword(){
    setState(() {
      _isInAsyncCall = true;
    });
    String phoneNumber = CoverPhone.coverPhone(_textNumberPhoneController.text.trim());

    if(_forgotPasswordBloc.isValidInfoForgot(phoneNumber)){
      FirestoreInforUser.checkPhone(phoneNumber).then((value){
        if(value){
          UserModel userModel = UserModel();
          userModel.phone = phoneNumber;
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => OTPScreen(mobileNumber: phoneNumber, user: userModel,)));
        }else{
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: white,
              content: Text('Số điện thoại không tồn tại'),
              actions: [
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text(dong, style: TextStyle(color: BLACK),))
              ],
            ),
          );
        }
      });

      setState(() {
        _isInAsyncCall = false;
      });
    }else{
      print('Not accept');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _forgotPasswordBloc.dispose();
    _textNumberPhoneController.dispose();
  }

}
