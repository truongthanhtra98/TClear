import 'package:flutter/material.dart';
import 'package:sample_one/src/app.dart';
import 'package:sample_one/src/data_models/service_model.dart';
import 'package:sample_one/src/resources/login_signup/change_password.dart';
import 'package:sample_one/src/resources/login_signup/login_screen.dart';
import 'package:sample_one/src/resources/login_signup/sign_up_page.dart';
import 'package:sample_one/src/resources/put_service/service_1.dart';
import 'package:sample_one/src/resources/put_service/service_2.dart';
import 'package:sample_one/src/resources/put_service/service_3.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp());
        case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/app':
        return MaterialPageRoute(
            builder: (_) => App(
                  currentPage: args,
                ));
      case '/change_pass':
        return MaterialPageRoute(
            builder: (_) => ChangePassword(args));
      case '/service1':
        if (args is ServiceModel) {
          return MaterialPageRoute(builder: (_) => Service1(args));
        }
        return _errorRoute();
      case '/service2':
        if (args is ServiceModel) {
          return MaterialPageRoute(builder: (_) => Service2(args));
        }
        return _errorRoute();
      case '/service3':
        if (args is ServiceModel) {
          return MaterialPageRoute(builder: (_) => Service3(args));
        }
        return _errorRoute();
      case '/service4':
        if (args is ServiceModel) {
          return MaterialPageRoute(builder: (_) => Service2(args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
