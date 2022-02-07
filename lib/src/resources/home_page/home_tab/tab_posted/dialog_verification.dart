import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/resources/home_page/home_tab/tab_posted/scan_screen.dart';
import 'package:sample_one/src/utils/colors.dart';

class DialogVerification extends StatelessWidget {
  final String idCustomer;
  final String dayWork;
  final DetailPutService detail;
  final List<String> listIdPartner;
  DialogVerification(this.idCustomer, this.detail, this.dayWork, this.listIdPartner);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Giới thiệu tính năng Xác minh mã QR', textAlign: TextAlign.center,),
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: BLACK),
      content: Text('Đây là tính năng sẽ hỗ trợ bạn xác nhận thông tin người giúp việc đến làm bằng cách quét mã QR code.'
          '\n\nCách sử dụng: \n- Chọn "Xác minh", sau đó quết mã QR code từ ứng dụng của người giúp việc và chờ hệ thống xác minh thông tin.'
    '\n- Khi hệ thống báo "Thông tin không đúng", vui lòng không cho phép Cộng tác viên thực hiên công việc và chọn "Gọi hỗ trợ" ngay.'
          '\n\nNếu thấy không cần thiết, chọn "Đóng" để thoát khỏi tính năng này.', textAlign: TextAlign.justify,),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentTextStyle: TextStyle(fontSize: 14, color: BLACK),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Đóng',
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),

        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ScanScreen(idCustomer, detail, dayWork, listIdPartner)));
          },
          child: Text(
            'Xác minh',
            style: TextStyle(color: Colors.green, fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
