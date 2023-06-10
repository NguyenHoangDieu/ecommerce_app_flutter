class DanhMucSanPham {
  int? id;
  String? tenDanhMuc;
  String? moTa;
  bool? trangThai;
  String? createdAt;

  DanhMucSanPham(
      {this.id,
        this.tenDanhMuc,
        this.moTa,
        this.trangThai,
        this.createdAt,
       });

  factory DanhMucSanPham.fromMap(Map<String, dynamic> map) {
    return DanhMucSanPham(
      id: map['id'] as int,
      tenDanhMuc: map['tenDanhMuc'] as String,
      moTa: map['moTa'] as String,
      trangThai: map['trangThai'] as bool,
    );
  }
  DanhMucSanPham.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenDanhMuc = json['tenDanhMuc'];
    moTa = json['moTa'];
    trangThai = json['trangThai'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenDanhMuc'] = this.tenDanhMuc;
    data['moTa'] = this.moTa;
    data['trangThai'] = this.trangThai;
    data['created_at'] = this.createdAt;
    return data;
  }
}