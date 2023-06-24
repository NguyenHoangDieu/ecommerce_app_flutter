class User {
  int? id;
  String? username;
  String? password;
  String? hoVaTen;
  String? dienThoai;
  String? token;

  User({this.id, this.username, this.password, this.hoVaTen, this.dienThoai});

  factory User.fromJson(Map<String, dynamic> json) {
    var user = User()
    ..id = json['id']
    ..username = json['username']
    ..password = json['password']
    ..hoVaTen = json['hoVaTen']
    ..dienThoai = json['dienThoai']
    ..token = json['accessToken'];
    return user;
  }
  factory User.fromLocalCache(Map<String, dynamic> json) {
    var user = User()
      ..id = json['id'] ?? 0
      ..token = json['accessToken'] ?? ''
      ..username = json['username'] ?? ''
      ..password = json['password'] ?? ''
      ..dienThoai = json['dienThoai']??''
      ..hoVaTen = json['hoVaTen'] ?? '';
    return user;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['hoVaTen'] = this.hoVaTen;
    data['dienThoai'] = this.dienThoai;
    data['accessToken'] = this.token;
    return data;
  }
}