import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sample_one/src/bloc/login_bloc.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/resources/dialog/dialog_login.dart';
import 'package:sample_one/src/resources/login_signup/forgot_password_page.dart';
import 'package:sample_one/src/resources/login_signup/otp_screen.dart';
import 'package:sample_one/src/resources/login_signup/sign_up_page.dart';
import 'package:sample_one/src/resources/widgets/password_text_field.dart';
import 'package:sample_one/src/resources/widgets/phone_number_text_field.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/cover_phone.dart';
import 'package:sample_one/src/utils/images.dart';
import 'package:sample_one/src/utils/strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc = LoginBloc();
  bool _showPass = false;
  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;

  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        opacity: 0.5,
        inAsyncCall: _isInAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        colorFilter:
                        ColorFilter.mode(BLACK, BlendMode.softLight),
                        image: AssetImage(imageBackGroudSplash),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                color: Colors.black38,
                child: ListView(
                  children: <Widget>[
                    _logo(),
                    _textDownLogo(),
                    Container(
                      padding: EdgeInsets.all(10),
                      //color: white,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: grey,
                              blurRadius: 2.0,
                              spreadRadius: 3.0,
                              offset: Offset(0.0, 0.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child:
                    Column(
                      children: [
                        PhoneNumberTextField(phoneController: _phoneController, stream: _loginBloc.phoneLoginStream,),
                        PasswordTextField(passController: _passController, stream: _loginBloc.paswordLoginStream, clickShowPass: onClickShowPass,showPass: _showPass,),
                        _buildLoginBtn(),
                      ],
                    )),

                    _buildLineText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(){
    return Center(
      child: Image.asset(iconLogo, color: orangeBackground, height: 100, width: 100,),
    );
  }

  Widget _textDownLogo(){
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        'Chào mừng đến với dịch vụ giúp việc của TClear',
        style: TextStyle(
            color: white, fontSize: 17, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onClickSignIn,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: GREEN,
        child: Row(
          children: [
            Icon(Icons.bubble_chart, color: GREEN,),
            Expanded(
              child: Text(
                dangNhap,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  letterSpacing: 0.0,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Icon(Icons.arrow_forward, color: white,)
          ],
        ),
      ),
    );
  }

  Widget _buildLineText(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUp()));
              },
              child: Text(dangKyNgay, style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w600),)),
          Spacer(),
          GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ForgotPassword()));
              },
              child: Text('Bạn quên mật khẩu?', style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w600),))
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginBloc.dispose();
    _passController.dispose();
    _phoneController.dispose();
  }

  void onClickShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onClickSignIn() {

    String phoneNumber = CoverPhone.coverPhone(_phoneController.text.trim());
    String password = _passController.text.trim();

      if(_loginBloc.isValidInfoLogin(phoneNumber, password)){
        setState(() {
          _isInAsyncCall = true;
        });
        Future.delayed(Duration(seconds: 2), (){
        FirestoreInforUser.checkExist(phoneNumber, password).then((value){
          if(value){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OTPScreen(
                        mobileNumber: phoneNumber, user: null,
                      ),
                ));
          }else{
            showDialog(
              context: context,
              builder: (BuildContext context) => LoginDialog(
                description:
                "Số điện thoại hoặc mật khẩu không đúng",
                buttonText: "Đóng",
              ),
            );
          }
          });
        setState(() {
          _isInAsyncCall = false;
        });
        });
      }else{
        print('Not accept');
      }



  }


}
