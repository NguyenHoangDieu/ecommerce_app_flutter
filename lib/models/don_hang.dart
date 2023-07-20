import 'dart:ffi';

class DonHang {
  List<Map<String, dynamic>>? listProduct;
  int? soLuong;
  int? donGia;
  int? id;
  int? idUser;
  String? ngayMua;
  String? typeNhanHang;
  String? typeThanhToan;
  String? trangThai;
  String? diaDiemNhanHang;
  double? giaTamTinh;
  double? giaDonHang;
  int? idKhoHang;
  String? createdAt;

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