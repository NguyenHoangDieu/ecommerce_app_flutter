class SanPham {
  int? id;
  String? tenSanPham;
  String? moTa;
  int? giaSanPham;
  bool? trangThai;
  String? image;
  int? idDanhMuc;
  int? idKhoHang;
  int? idGiamGia;
  String? createdAt;

  SanPham(
      {this.id,
        this.tenSanPham,
        this.moTa,
        this.giaSanPham,
        this.trangThai,
        this.image,
        this.idDanhMuc,
        this.idKhoHang,
        this.idGiamGia,
        this.createdAt,});

  SanPham.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenSanPham = json['tenSanPham'];
    moTa = json['moTa'];
    giaSanPham = json['giaSanPham'];
    trangThai = json['trangThai'];
    image = json['image'];
    idDanhMuc = json['idDanhMuc'];
    idKhoHang = json['idKhoHang'];
    idGiamGia = json['idGiamGia'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenSanPham'] = this.tenSanPham;
    data['moTa'] = this.moTa;
    data['giaSanPham'] = this.giaSanPham;
    data['trangThai'] = this.trangThai;
    data['image'] = this.image;
    data['idDanhMuc'] = this.idDanhMuc;
    data['idKhoHang'] = this.idKhoHang;
    data['idGiamGia'] = this.idGiamGia;
    data['created_at'] = this.createdAt;
    return data;
  }
}