import 'package:flutter/material.dart';

class RePasswordTextField extends StatefulWidget {
  final TextEditingController passController;
  final Function clickShowPass;
  final Stream stream;

  RePasswordTextField({this.passController, this.clickShowPass, this.stream});
  @override
  _RePasswordTextFieldState createState() => _RePasswordTextFieldState();
}

class _RePasswordTextFieldState extends State<RePasswordTextField> {
  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'NHẬP LẠI MẬT KHẨU',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Container(
          height: 40.0,
          child: TextField(
            controller: widget.passController,
            obscureText: _showPass ? false : true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPass ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                  color: Colors.black12,
                ),
                onPressed: onClickShowPass,
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

  void onClickShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

}
