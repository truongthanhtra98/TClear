import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController emailController;
  final Stream stream;

  EmailTextField({this.emailController, this.stream});

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'EMAIL ĐỂ NHẬN BIỆN NHẬN',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Container(
          height: 40.0,
          child: TextField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
