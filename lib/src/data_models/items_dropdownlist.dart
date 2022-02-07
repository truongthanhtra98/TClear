class Item {
  int idItem;
  int thoiGian;
  int soNguoiLam;
  String dienTich;
  String soPhong;

  Item(this.idItem, this.thoiGian, {this.dienTich, this.soPhong, this.soNguoiLam});

  static List<Item> getWorkIn(){
    return <Item>[
      Item(1 , 3, dienTich: "15 m2", soPhong:  "4 Phòng"),
      Item(2 , 4, dienTich: "20 m2", soPhong:  "5 Phòng"),
      Item(3 , 5, dienTich: "25 m2", soPhong:  "6 Phòng"),
      Item(4 , 5, dienTich: "30 m2", soPhong:  "7 Phòng"),
    ];
  }

  static List<Item> getArea(){
    return <Item>[
      Item(1, 4 , dienTich: "Tối đa 80m2", soNguoiLam: 2),
      Item(2 , 3, dienTich: "Tối đa 100m2", soNguoiLam: 3),
      Item(3 , 4, dienTich: "Tối đa 150m2", soNguoiLam: 3),
    ];
  }

  @override
  String toString() {
    return '$thoiGian h - $dienTich - $soPhong';
  }


}