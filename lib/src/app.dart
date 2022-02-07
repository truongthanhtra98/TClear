import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/get_store.dart';
import 'package:sample_one/src/resources/home_page/home_page.dart';
import 'file:///D:/sample_one/lib/src/resources/login_signup/login_screen.dart';

class App extends StatefulWidget {
  final int currentPage;
  App({Key key, this.currentPage}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();

    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: //QuestionPage()
        user != null
            ? HomePage(
          user: user, currentIndex: widget.currentPage,)
            : LoginScreen()
    );
    //body: Service2(),
    //);
  }

  @override
  void dispose() {
    super.dispose();
  }
}