import 'package:flutter/material.dart';

class PhoneNumberTextField extends StatefulWidget {
  final TextEditingController phoneController;
  final Stream stream;

  PhoneNumberTextField({this.phoneController, this.stream});

  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'SỐ ĐIỆN THOẠI',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),

        Container(
          height: 40.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: widget.phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              prefixIcon: Container(
                padding: EdgeInsets.only(right: 10.0),
                color: Colors.grey.withOpacity(0.2),
                width: 80.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'VN +84',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        Container(
          height: 15.0,
          child: StreamBuilder(
            stream: widget.stream,
            builder: (context, snapshot) => Row(mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  snapshot.hasError ? snapshot.error : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
