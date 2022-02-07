import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sample_one/src/bloc/forgot_password_bloc.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/resources/widgets/password_text_field.dart';
import 'package:sample_one/src/resources/widgets/repasssword_text_filed.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/form_page.dart';
import 'package:sample_one/src/utils/strings.dart';

class ChangePassword extends StatefulWidget {
  final String idUser;

  ChangePassword(this.idUser);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ForgotPasswordBloc bloc = new ForgotPasswordBloc();
  bool _showPass = false;
  // manage state of modal progress HUD widget
  bool _isInAsyncCall = false;

  TextEditingController _passController = new TextEditingController();
  TextEditingController _rePassController = new TextEditingController();

  Widget _buildChangePass() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onClickChange,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: GREEN,
        child: Text(
          thayDoiPassword,
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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.5,
      inAsyncCall: _isInAsyncCall,
      progressIndicator: CircularProgressIndicator(),
      child: FormPage(
        textBar: thayDoiPassword,
        content: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      child: ListView(
        children: <Widget>[
          PasswordTextField(
            passController: _passController,
            stream: bloc.passForgotStream,
            clickShowPass: onClickShowPass,
            showPass: _showPass,
          ),
          SizedBox(
            height: 10.0,
          ),
          RePasswordTextField(
            passController: _rePassController,
            stream: bloc.rePassStream,
            clickShowPass: onClickShowPass,
          ),
          SizedBox(
            height: 10.0,
          ),
          _buildChangePass(),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passController.dispose();
    _rePassController.dispose();
    bloc.dispose();
  }

  void onClickShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onClickChange() {

    String pass = _passController.text.trim();
    String rePass = _rePassController.text.trim();
    if (bloc.isValidPassForgot(pass, rePass)) {
      setState(() {
        _isInAsyncCall = true;
      });
      FirestoreInforUser.updatePassword(widget.idUser, pass).then((value) {
        if (value) {
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text(
                  'Bạn đã thay đổi thành công, bây giờ tiếp tục đăng nhập nào',
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    },
                    child: Text(tiepTuc, style: TextStyle(color: GREEN),),
                  )
                ],
              ));
        } else {
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text('Thay đổi password không thành công'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(dong, style: TextStyle(color: BLACK),))
                ],
              ));
        }
        setState(() {
          _isInAsyncCall = false;
        });
      });

    } else {
      print('Not accept');
    }
  }
}
