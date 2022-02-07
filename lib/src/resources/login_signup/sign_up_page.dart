import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sample_one/src/bloc/sign_up_bloc.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/resources/dialog/dialog_signup.dart';
import 'package:sample_one/src/resources/login_signup/login_screen.dart';
import 'package:sample_one/src/resources/login_signup/otp_screen.dart';
import 'package:sample_one/src/resources/widgets/email_text_field.dart';
import 'package:sample_one/src/resources/widgets/name_text_field.dart';
import 'package:sample_one/src/resources/widgets/password_text_field.dart';
import 'package:sample_one/src/resources/widgets/phone_number_text_field.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/cover_phone.dart';
import 'package:sample_one/src/utils/form_page.dart';
import 'package:sample_one/src/utils/strings.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpBloc bloc = new SignUpBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  bool _showPass = false;
  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;

  Widget _buildAgreeText(){
    return RichText(
      text: TextSpan(
        text: 'Tôi đồng ý với Các ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(
              text: 'điều khoản và chính sách của TClear',
            recognizer: new TapGestureRecognizer()..onTap = () {
              //launch('https://www.google.com');
            },
              style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDangKyBtn() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: clickOnSignUp,
        padding: EdgeInsets.all(15.0),
        color: GREEN,
        child: Text(
          dangKy,
          style: TextStyle(
            color: white,
            letterSpacing: 0.0,
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildEnoughAccountTxt(){
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(daCoTaiKhoan, style: TextStyle(fontSize: 15.0),),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              dangNhap,
              style: TextStyle(
                  fontSize: 15.0,
                  color: orangeBackground
              ),
            ),
          ),
        ],
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
        textBar: dangKyTaiKhoan,
        content: getBody(),
      ),
    );
  }

  Widget getBody(){
    return Container(
      child: ListView(
        children: <Widget>[
          NameTextField(nameController: _nameController, stream: bloc.nameStream,),
          PhoneNumberTextField(phoneController: _phoneController, stream: bloc.phoneStream,),
          EmailTextField(emailController: _emailController, stream: bloc.emailStream,),
          PasswordTextField(passController: _passController, stream: bloc.paswordStream, clickShowPass: onClickShowPass,showPass: _showPass,),
          _buildAgreeText(),
          SizedBox(height: 10.0,),
          _buildDangKyBtn(),
          SizedBox(height: 10.0,),
          _buildEnoughAccountTxt(),
        ],
      ),
    );
  }

  void onClickShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passController.dispose();
    _phoneController.dispose();
    super.dispose();
    bloc.dispose();
  }

  void clickOnSignUp() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = CoverPhone.coverPhone(_phoneController.text.trim());
    String password = _passController.text.trim();
    UserModel user = UserModel();
    user.name = name;
    user.email = email;
    user.phone = phone;
    user.password = password;
    if(bloc.isValidInfoSignUp(name, phone, email, password)){

      print('nereww ${user.name}');
      setState(() {
        _isInAsyncCall = true;
      });
      Future.delayed(Duration(seconds: 2), ()
      {
        FirestoreInforUser.checkPhone(phone).then((value) {
          if (value) {
            print('Phone number exist');
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  SignUpDialog(
                    description:
                    "Số điện thoại đã được sử dụng, bạn có muốn đăng nhập với số này?",
                    buttonText1: "Đóng",
                    buttonText2: "Đồng ý",
                  ),
            );
          } else {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) =>
                    OTPScreen(mobileNumber: phone, user: user,)));
          }
          setState(() {
            _isInAsyncCall = false;
          });
        });
      });
    }else{
      print('Not accept');
    }

//    Future.delayed(Duration(seconds: 2), (){
//      bloc.checkSignUp(user, context);
//      setState(() {
//        _isInAsyncCall = false;
//      });
//    });
  }

}
