import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/resources/dialog/dialog_signup.dart';
import 'package:sample_one/src/resources/login_signup/otp_screen.dart';
import 'package:sample_one/src/valicators/validation.dart';

class SignUpBloc{

  // kiểm tra hợp lệ ấy mà
  StreamController _nameController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passwordContoller = new StreamController();

  Stream get nameStream => _nameController.stream;

  Stream get phoneStream => _phoneController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get paswordStream => _passwordContoller.stream;

  bool isValidInfoSignUp(String name, String phone, String email, String password){

    if(!Validation.isValidName(name)){
      _nameController.sink.addError('Bạn chưa nhập tên vào');
      return false;
    }
    _nameController.sink.add('ok');
    if(!Validation.isValidPhone(phone)){
      _phoneController.sink.addError('Số điện thoại không hợp lệ');
      return false;
    }
    _phoneController.sink.add('ok');
    if(!Validation.isValidEmail(email)){
      _emailController.sink.addError('Email không hợp lệ');
      return false;
    }
    _emailController.sink.add('ok');
    if(!Validation.isValidPassword(password)){
      _passwordContoller.sink.addError('Password không hợp lệ');
      return false;
    }
    _passwordContoller.sink.add('ok');
    return true;
  }

  void dispose(){
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _passwordContoller.close();
  }


}