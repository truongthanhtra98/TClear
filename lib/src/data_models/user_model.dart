import 'package:password/password.dart';
import 'package:sample_one/src/utils/data_holder.dart';

class UserModel {
  String _id;
  String _name;
  String _email;
  String _phone;
  String _password;
  String _image;

  UserModel({id, name, email, phone, password,
      image});

  UserModel.fromMap(Map<String, dynamic> data, String id)
      : _name = data['name'],
        _email = data['email'],
        _phone = data['phone'],
        _password = data['password'],
        _image = data['image'],
        _id = id;

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'email': _email,
      'phone': _phone,
      'password': Password.hash(_password, algorithm),
    };
  }

  Map<String, dynamic> toMapContact() {
    return {
      'name': _name,
      'email': _email,
      'phone': _phone,
    };
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
