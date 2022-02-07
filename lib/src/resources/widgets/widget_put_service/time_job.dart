import 'package:flutter/material.dart';

class TimeJob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(color: Colors.grey, width: 1)),
      child:
        Center(
          child: Text("ƯỚC Tinh Thời Gian CTV Đến Nhà Bạn Lúc 12:00", textAlign: TextAlign.center,style: TextStyle(
            color: Colors.black, fontSize: 15
          ),),
        )

    );
  }
}
