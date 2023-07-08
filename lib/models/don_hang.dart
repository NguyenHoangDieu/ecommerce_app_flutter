import 'dart:ffi';

class DonHang {
  List<Map<String, dynamic>>? listProduct;
  int? soLuong;
  int? donGia;
  int? id;
  int? idUser;
  DateTime? ngayMua;
  String? typeNhanHang;
  String? typeThanhToan;
  String? trangThai;
  String? diaDiemNhanHang;
  double? giaTamTinh;
  double? giaDonHang;
  int? idKhoHang;
  DateTime? createdAt;

  DonHang(
      {this.listProduct,
        this.soLuong,
        this.donGia,
        this.id,
        this.idUser,
        this.ngayMua,
        this.typeNhanHang,
        this.typeThanhToan,
        this.trangThai,
        this.diaDiemNhanHang,
        this.giaTamTinh,
        this.giaDonHang,
        this.idKhoHang,
        this.createdAt
      });

  DonHang.fromJson(Map<String, dynamic> json) {
    // if (json['chiTietDonHang'] != null) {
    //   chiTietDonHang = <ChiTietDonHang>[];
    //   json['chiTietDonHang'].forEach((v) {
    //     chiTietDonHang!.add(new ChiTietDonHang.fromJson(v));
    //   });
    // }
    soLuong = json['soLuong'];
    donGia = json['donGia'];
    id = json['id'];
    idUser = json['idUser'];
    ngayMua = json['ngayMua'];
    typeNhanHang = json['typeNhanHang'];
    typeThanhToan = json['typeThanhToan'];
    trangThai = json['trangThai'];
    diaDiemNhanHang = json['diaDiemNhanHang'];
    giaTamTinh = json['giaTamTinh'];
    giaDonHang = json['giaDonHang'];
    idKhoHang = json['idKhoHang'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soLuong'] = this.soLuong;
    data['donGia'] = this.donGia;
    data['id'] = this.id;
    data['idUser'] = this.idUser;
    data['ngayMua'] = this.ngayMua;
    data['typeNhanHang'] = this.typeNhanHang;
    data['typeThanhToan'] = this.typeThanhToan;
    data['trangThai'] = this.trangThai;
    data['diaDiemNhanHang'] = this.diaDiemNhanHang;
    data['giaTamTinh'] = this.giaTamTinh;
    data['giaDonHang'] = this.giaDonHang;
    data['idKhoHang'] = this.idKhoHang;
    data['created_at'] = this.createdAt;
    return data;
  }
}

// class ChiTietDonHang {
//   int? id;
//   int? idDonHang;
//   int? idSanPham;
//   int? soLuong;
//
//   ChiTietDonHang({this.id, this.idDonHang, this.idSanPham, this.soLuong});
//
//   ChiTietDonHang.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idDonHang = json['idDonHang'];
//     idSanPham = json['idSanPham'];
//     soLuong = json['soLuong'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['idDonHang'] = this.idDonHang;
//     data['idSanPham'] = this.idSanPham;
//     data['soLuong'] = this.soLuong;
//     return data;
//   }
// }