import 'package:flutter/material.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/form_page.dart';

class DetailService2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormPage(
      textBar: 'Chi tiết công viêc',
      content: _content(),
    );
  }

  Widget _content(){
    return ListView(
        children: <Widget>[
        Text('Tổng quát', style: TextStyle(fontWeight: FontWeight.bold),),
        Text('- Quét bụi, quét mạng nhện trên trần nhà\n- Vệ sinh phần tường nhà (quét bụi hoặc lau)\n- Phủi bụi rèm cửa, vệ sinh cửa ra vào,'
            'cửa số\n- Phủi bụi, lau chùi bề mặt bàn ghế, tủ kệ, các vật dụng, đồ trang trí...\n- Quét bụi và lau sàn.\n- Thu gom và đổ rác.',
          style: TextStyle(
            color: grey,
            fontSize: 14,
            height: 2,
          ),

        ),
        Container(
          height: 1,
          color: grey,
          margin: EdgeInsets.only(top: 15, bottom: 15),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/icon_phong_khach.png', height: 50, width: 50,),
            ),
            Expanded(flex: 4, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Phòng khách', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Vệ sinh kỹ phần cửa, các bề mặc kính, các kệ tủ...'),
              ],
            ))
          ],
        ),

        Container(
          height: 1,
          color: grey,
          margin: EdgeInsets.only(top: 15, bottom: 15),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/icon_nha_bep.png', height: 50, width: 50,),
            ),
            Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nhà bếp', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Vệ sinh tủ lạnh, lò vi ba, lò nướng, bếp nấu, cá tủ kệ'),
              ],
            ))
          ],
        ),

        Container(
          height: 1,
          color: grey,
          margin: EdgeInsets.only(top: 15, bottom: 15),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/icon_phong_ngu.png', height: 50, width: 50,),
            ),
            Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Phòng ngủ', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Vệ sinh vạc giường, quét bụi, lau đầu giường, gầm giường...'),
              ],
            ))
          ],
        ),

        Container(
          height: 1,
          color: grey,
          margin: EdgeInsets.only(top: 15, bottom: 15),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/icon_toilet.png', height: 50, width: 50,),
            ),
            Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nhà vệ sinh', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Vệ sinh tường, sàn nhà, các góc tường; khu vực bồ rửa mặt, bồn tắm; tẩy uế bồn cầu; vệ sinh khu vực cống, nắp thoát nước...'),
              ],
            ))
          ],
        ),
      ],
    );
  }
}
