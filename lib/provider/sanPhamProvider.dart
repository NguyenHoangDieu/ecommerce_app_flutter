import 'dart:convert';

import 'package:ecommerce_app_flutter/models/san_pham.dart';
import 'package:ecommerce_app_flutter/utils/common.dart';

import '../utils/api.dart';

class ProductProvider{
  static Future<List<SanPham>> fetchListProduct() async {
    List<SanPham> result = [];
    final host = await Services.getApiLink();
    final requestUrl = '$host/api/SanPham/GetAllProduct';
    final response = await Services.doGet(requestUrl, "");
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
        List<dynamic> listItem = body;
        for (var item in listItem) {
          result.add(SanPham.fromJson(item));
        }
    }
    return result;
  }

  static Future<List<SanPham>> fetchListProductByCategory(int idDanhMuc) async {
    List<SanPham> result = [];
    final host = await Services.getApiLink();
    final requestUrl = '$host/api/DanhMucSanPham/GetProductsByCategory?idDanhMuc=$idDanhMuc';
    final response = await Services.doGet(requestUrl, "");
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body;
      for (var item in listItem) {
        result.add(SanPham.fromJson(item));
      }
    }
    return result;
  }



}