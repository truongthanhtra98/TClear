import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:password/password.dart';

Map<String, Uint8List> imageData = Map();

List<String> listPopupWait = ['Thay đổi ngày giờ', 'Hủy công việc này'];
List<String> listPopupRepeat = ['Xóa lịch lặp lại'];

var formatter = new DateFormat('dd/MM/yyyy');
var formatter1 = new DateFormat('yyyy-MM-dd');
var formatterHasHour = new DateFormat('HH:mm, dd/MM/yyyy');
var formatterHour = new DateFormat('HH:mm');

final oCcy = new NumberFormat("#,##0", "vi_VN");

final algorithm = PBKDF2();
