import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passController;
  final bool showPass;
  final Function clickShowPass;
  final Stream stream;

  PasswordTextField({this.passController, this.clickShowPass, this.stream, this.showPass});
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'MẬT KHẨU',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Container(
          height: 40.0,
          child: TextField(
            controller: widget.passController,
            obscureText: widget.showPass ? false : true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              suffixIcon: IconButton(
                icon: Icon(
                  widget.showPass ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                  color: Colors.black12,
                ),
                onPressed: widget.clickShowPass,
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
