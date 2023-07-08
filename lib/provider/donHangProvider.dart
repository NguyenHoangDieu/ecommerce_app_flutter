import 'dart:convert';

import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:ecommerce_app_flutter/utils/common.dart';

import '../models/cart.dart';
import '../models/user.dart';

class DonHangProvider{
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