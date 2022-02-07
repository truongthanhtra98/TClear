import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';
import 'package:sample_one/src/data_models/items_dropdownlist.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/data_holder.dart';

class ChiTietCongViec extends StatefulWidget {
  final DetailPutService detailPutService;

  ChiTietCongViec(this.detailPutService);
  @override
  _ChiTietCongViecState createState() => _ChiTietCongViecState();
}

class _ChiTietCongViecState extends State<ChiTietCongViec> {
  bool a;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //address location
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Địa chỉ", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
              Expanded(child: Text('${widget.detailPutService.locationWork.formattedAddress}'), flex: 2,),
            ],
          ),
        ),
        //number home (số nhà)
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Số nhà/căn hộ", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
              Expanded(child: Text("${widget.detailPutService.apartment.apartmentNumber}"), flex: 2,),
            ],
          ),
        ),
        //type home (loại nhà)
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Loại nhà", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
              Expanded(child: Text("${widget.detailPutService.apartment.typeHome}"), flex: 2,),
            ],
          ),
        ),
        // time work(thời gian làm việc)
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Thời gian làm việc", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
              Expanded(child: Text("${widget.detailPutService.hour}, ${formatter.format(widget.detailPutService.day).toString()}"), flex: 2,),
            ],
          ),
        ),
        //Khoi luong cong viec
        widget.detailPutService.weightWork != null ?
        khoiLuongCongViec(widget.detailPutService.weightWork ) : SizedBox(),
        //Da bao gom
        widget.detailPutService is ModelService1 ?
        daBaoGom(widget.detailPutService) : SizedBox(),
        //repeat
        widget.detailPutService is ModelService1?
        repeat(widget.detailPutService) : SizedBox(),

        // have pet
        widget.detailPutService is ModelService1 ?
        pet(widget.detailPutService) : SizedBox(),

        //for service 3
        widget.detailPutService is ModelService3?
        _widgetForService3(widget.detailPutService) : SizedBox(),
        //note
        widget.detailPutService.note != null?
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Ghi chú cho người làm", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
              Expanded(child: Text("${widget.detailPutService.note}"), flex: 2,),
            ],
          ),
        ): SizedBox(),
      ],
    );
  }

  Widget pet(ModelService1 modelService1){
    if(modelService1.pet != null){
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text("Thú cưng", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
            Expanded(child: Text("${modelService1.pet}"), flex: 2,),
          ],
        ),
      );}

    return SizedBox();
  }

  Widget khoiLuongCongViec(Item item){

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Text("Khối lượng công việc", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
          Expanded(child: Text("${klcv(item).toString()}"), flex: 2,),
        ],
      ),
    );
  }

  String klcv(Item item){
    String s = '';
    if(item.soNguoiLam != null){
      s += '${item.soNguoiLam} người làm -';
    }

    if(item.soPhong != null){
      s += '${item.soPhong} -';
    }

    if(item.dienTich != null){
      s += ' ${item.dienTich} -';
    }

    if(item.thoiGian != null){
      s += ' trong ${item.thoiGian} giờ';
    }

    return s;
  }

  Widget daBaoGom(ModelService1 modelService1){
    String baoGom = "";
    if(modelService1.iron) baoGom += "Ủi đồ - ";
    if(modelService1.cooking) baoGom += "Nấu ăn - ";
    if(modelService1.mop) baoGom += "Đem theo dụng cụ";

    if(baoGom != ""){
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text("Đã bao gồm", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
            Expanded(child: Text("$baoGom", style: TextStyle(color: GREEN),), flex: 2,),
          ],
        ),
      );
    }

    return SizedBox();
  }

  Widget repeat(ModelService1 modelService1){

    if(modelService1.mapRepeat.containsValue(true)){
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text("Lặp lại", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
            Expanded(child: Text("${coverDayRepeat(modelService1.mapRepeat)}", style: TextStyle(color: Colors.green),), flex: 2,),
          ],
        ),
      );
    }else{
      return SizedBox();
    }

  }
  // create for service3
  Widget _widgetForService3(ModelService3 modelService3){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Số người ăn", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
                Expanded(child: Text("${modelService3.numberPersonEat} người"), flex: 2,),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Số món", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
                Expanded(child: Text("${modelService3.numberFood} món"), flex: 2,),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Khẩu vị", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
                Expanded(child: Text("${modelService3.taste}"), flex: 2,),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Trái cây", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
                Expanded(child: Text(modelService3.hasFruit ? "Có" : "Không"), flex: 2,),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Người làm đi chợ", style: TextStyle(color: Color(0xFFBDBDBD),),), flex: 1,),
                Expanded(child: Text(modelService3.goMarket ? "Có" : "Không"), flex: 2,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String coverDayRepeat(Map<String, dynamic> mapRepeat){
    String cover = "";
    mapRepeat.forEach((key, value) {
      if(value == true){
        cover += key + "  ";
      }
    });
    return cover;
  }
}
