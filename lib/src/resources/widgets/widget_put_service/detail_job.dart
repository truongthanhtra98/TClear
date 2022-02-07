import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/resources/put_service/detail_work_service2.dart';

class DetailJob extends StatefulWidget {
  @override
  _DetailJobState createState() => _DetailJobState();
}

class _DetailJobState extends State<DetailJob> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("CHI TIẾT CÔNG VIỆC",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            )),
        Text(
          "- Quét bụi, quét mạng nhện trên trần nhà\n- Vệ sinh phần tường nhà(quét bụi hoặc lau)\n"
          "- Phủi bụi rèm cửa, vệ sinh cửa ra vào cửa sổ\n- Phủi bụi, lau chùi bề mặt bàn ghế, "
          "tủ kệ, vật dụng, đồ trang trí\n- Quét bụi và lau sàn\n- Thu gom và đổ rác",
          overflow: TextOverflow.fade,
          maxLines: 5,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              child: Text(
                "xem chi tiết",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailService2()));
              },
            ),
          ],
        )
      ],
    );
  }
}
