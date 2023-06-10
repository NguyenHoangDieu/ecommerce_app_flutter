class User {
  int? id;
  String? username;
  String? password;
  String? hoVaTen;
  String? dienThoai;
  String? token;

  User({this.id, this.username, this.password, this.hoVaTen, this.dienThoai});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    hoVaTen = json['hoVaTen'];
    dienThoai = json['dienThoai'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['hoVaTen'] = this.hoVaTen;
    data['dienThoai'] = this.dienThoai;
    return data;
  }
}