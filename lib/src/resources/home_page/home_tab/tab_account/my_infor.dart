import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sample_one/src/bloc/check_infor_bloc.dart';
import 'package:sample_one/src/data_models/user_model.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/resources/widgets/get_image_storage.dart';
import 'package:sample_one/src/utils/colors.dart';

class MyInforPage extends StatefulWidget {
  final UserModel userModel;

  MyInforPage(this.userModel);
  @override
  _MyInforPageState createState() => _MyInforPageState();
}

class _MyInforPageState extends State<MyInforPage> {
  File _image;
  final picker = ImagePicker();
  bool _checkInfor = false;
  CheckInforBloc _checkInforBloc = CheckInforBloc();
// manage state of modal progress HUD widget
  bool _isInAsyncCall = false;

  var _phoneEditingController = TextEditingController();
  var _emailEditingController = TextEditingController();
  var _nameEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneEditingController.text = widget.userModel.phone;
    _emailEditingController.text = widget.userModel.email;
    _nameEditingController.text = widget.userModel.name;
  }

  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
      _checkInfor = checkChange();
      print('Image Path $_image');
    });
  }

  Future uploadPic(String name, String email, BuildContext context) async{
    if(_image!= null){
      String fileName = 'avatar/'+_image.path.split('/').last;
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      FirestoreInforUser.updateImageUser(widget.userModel.id, fileName, email, name,);
      print("Profile Picture uploaded");
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }else{
      FirestoreInforUser.updateImageUser(widget.userModel.id, widget.userModel.image, email, name,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân', style: TextStyle(color: white),),
        backgroundColor: orangeBackground,
      ),
      body: ModalProgressHUD(
        opacity: 0.5,
        inAsyncCall: _isInAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(80),
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
                          backgroundColor: white,
                          radius: 81,
                          child: ClipOval(
                            child: new SizedBox(
                                width: 160.0,
                                height: 160.0,
                                child: (_image!=null)? Image.file(_image, fit: BoxFit.cover,):
                                (widget.userModel.image != null ? GetImageAvtStorage(widget.userModel.image) : Image.asset('assets/images/avatar.jpg', fit: BoxFit.fill,))
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 80, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: grey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: grey,
                                  blurRadius: 1.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.0, 0.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor: grey,
                              radius: 20,
                              child: ClipOval(
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt,
                                    size: 20.0, color: BLACK,
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phoneEditingController,
                  //textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    //fillColor: Colors.black12,
                    labelText: 'Số điện thoại',
                    enabled: false,
//                  border: OutlineInputBorder(
//                      borderSide: BorderSide(
//                          width: 1,
//                          style: BorderStyle.solid)),
                    contentPadding: EdgeInsets.all(0),
                    filled: true,
                  ),
                  readOnly: true,
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder(
                    stream: _checkInforBloc.nameStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _nameEditingController,
                        onChanged: (value){
                          setState(() {
                            _checkInfor = checkChange();
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Tên bạn',
                            contentPadding: EdgeInsets.all(0),
                            errorText: snapshot.hasError ? snapshot.error : null),
                      );
                    }),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder(
                    stream: _checkInforBloc.emailStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value){
                          setState(() {
                            _checkInfor = checkChange();
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            contentPadding: EdgeInsets.all(0),
                            errorText: snapshot.hasError ? snapshot.error : null),
                      );
                    }),
                SizedBox(
                  height: 30,
                ),

                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: Text('Cập nhật thông tin', style: TextStyle(color: white),),
                    color: GREEN,
                    onPressed: _checkInfor? (){
                      String phone = _phoneEditingController.text.trim();
                      String name = _nameEditingController.text.trim();
                      String email = _emailEditingController.text.trim();
                      UserModel user = UserModel();
                      user.phone = phone;
                      user.name = name;
                      user.email = email;
                      if(_checkInforBloc.isValidInfoSignUp(user)){
                        showDialog(context: context, child: AlertDialog(
                          content: Text('Bạn xác nhận cập nhật thông tin chứ?'),
                          actions: [
                            FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Đóng')),
                            FlatButton(onPressed: (){
                              setState(() {
                                _isInAsyncCall = true;
                              });
                              //update upload
                              Navigator.of(context).pop();
                              Future.delayed(Duration(seconds: 3), (){
                                uploadPic(name, email, context);
                                setState(() {
                                  _isInAsyncCall = false;
                                });
                                showDialog(context: context, barrierDismissible: false,child: AlertDialog(
                                  content: Text('Bạn đã thay đổi thông tin thành công'),
                                  actions: [
                                    FlatButton(onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/app', (Route<dynamic> route) => false, arguments: 3), child: Text('Đóng'))
                                  ],
                                ));
                              });



                            }, child: Text('Đồng ý', style: TextStyle(color: GREEN),)),
                          ],
                        ));
                      }else{
                        print('infor not true');
                      }

                    } : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkChange(){
    if(_nameEditingController.text.trim() != widget.userModel.name || _emailEditingController.text.trim() != widget.userModel.email || _image != null){
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _image = null;
    _emailEditingController.dispose();
    _nameEditingController.dispose();
    _phoneEditingController.dispose();
    super.dispose();
  }
}
