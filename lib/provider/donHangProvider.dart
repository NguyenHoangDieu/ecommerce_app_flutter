import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:ecommerce_app_flutter/utils/common.dart';

import '../models/cart.dart';
import '../models/don_hang.dart';
import '../models/user.dart';

class DonHangProvider{

  static Future<List<DonHang>> fetchListDonHang(int userId) async {
    List<DonHang> result = [];
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/DonHang/DanhSachDonHang?userId=$userId';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body['data'];
      for (var item in listItem) {
        result.add(DonHang.fromJson(item));
      }
    }
    return result;
  }
  static Future<DonHang> getDetail(int idOrder) async {
    var order = DonHang();
    var host = await Services.getApiLink();
    var requestUrl = "$host/api/DonHang/GetDetailDonHang?id=$idOrder";
    var requestToken = await Services.getToken();
    var response = await Services.doPost(requestUrl, requestToken, null);
    if (response.isSuccess()) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']&&responseBody['message'] == 'Successfully') {
        //thông tin cơ bản
        var map = responseBody['data'] as Map<String, dynamic>;
        order.id = map['id'] as int;
        order.donGia = (map['giaDonHang'] ?? 0) as int;
        order.diaDiemNhanHang = (map['diaDiemNhanHang'] ?? "") as String;
        order.typeNhanHang = (map['typeNhanHang'] ?? "") as String;
        //lấy thông tin chi tiết đơn hàng
        if (map['chiTietDonHang'] != null) {
          var listChiTietDonHang = map['chiTietDonHang'] as List<dynamic>;
          for (var chitiet in listChiTietDonHang) {
            var quantity = (chitiet['soLuong'] ?? 0) as int;
            var idSanPham = (chitiet['idSanPham'] ?? 0) as int;
              order.listProduct?.add({
                'idSanPham': idSanPham,
                'soLuong': quantity
              });
          }
        }
      }
    }

    return order;
  }
  static Future<int> onDatHang(
      User user,
      String typeNhanHang,
      String diaDiemNhanHang,
      List<Cart> carts,
      double totalPrice,
      double tempOrderPrice,
      ) async {
    int result = 0;
    final host = await Services.getApiLink();
    final requestUrl = '$host/api/DonHang/MuaHang';
    final requestToken = await Services.getToken();

    List<Map> products = [];
    for (var cart in carts) {
      products.add({
        "idGioHang": "0",
        "idSanPham": cart.productId,
        "soLuong": cart.count
      });
    }
    final requestBody = jsonEncode({
      "sanPham": products,
      "idUser": user.id,
      "typeNhanHang": typeNhanHang,
      'giaDonHang': totalPrice,
      'giaTamTinh': tempOrderPrice,
      "diaDiemNhanHang": diaDiemNhanHang,
      'trangThai': 'Đã đặt hàng'
    });
    final response = await Services.doPost(requestUrl, requestToken, requestBody);
    if (response.isSuccess()) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        result = int.parse(responseBody['data'] ?? "0");
      }
    }
    return result;
  }
}