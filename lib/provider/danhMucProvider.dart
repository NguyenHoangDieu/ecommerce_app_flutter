import 'dart:convert';
import 'package:ecommerce_app_flutter/utils/common.dart';

import '../models/danh_muc_san_pham.dart';
import '../utils/api.dart';

class CategoryProvider{
  static Future<List<DanhMucSanPham>> fetchListDanhMuc() async {
    List<DanhMucSanPham> result = [];
    final host = await Services.getApiLink();
    final requestUrl = '$host/api/DanhMucSanPham/GetAllCategory';
    final response = await Services.doGet(requestUrl, '');
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body;
      for (var item in listItem) {
        result.add(DanhMucSanPham.fromMap(item));
      }
    }
    return result;
  }

  static Future<DanhMucSanPham> getDetailCategory(int idDanhMuc) async{
    DanhMucSanPham result = DanhMucSanPham();
    final host = await Services.getApiLink();
    final requestUrl = '$host/api/DanhMucSanPham/GetCategoryById?id=$idDanhMuc';
    final response = await Services.doGet(requestUrl, "");
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      result.id = body['id'];
      result.tenDanhMuc = body['tenDanhMuc'];
      result.moTa = body['moTa'];
    }
    return result;
  }

}