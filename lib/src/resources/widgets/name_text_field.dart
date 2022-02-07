import 'package:flutter/material.dart';

class NameTextField extends StatefulWidget {
  final TextEditingController nameController;
  final Stream stream;

  NameTextField({this.nameController, this.stream});

  @override
  _NameTextFieldState createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TÊN LIÊN HỆ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Container(
          height: 40.0,
          child: TextField(
            controller: widget.nameController,
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
