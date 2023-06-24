import 'package:ecommerce_app_flutter/models/san_pham.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cart.dart';

class CartChangeNotifier extends ChangeNotifier {
  List<Cart> _items = [];
  List<Cart> get items => _items;
  int get countProduct => _items.length;
  set items(List<Cart> cart) {
    _items = cart;
  }

  void init(List<Cart> carts) {
    _items = carts;
  }

  void addItem(SanPham product) {
    var isExisted = _items.firstWhereOrNull((item) => item.productId == product.id) != null;
    if (isExisted) {
      _items.firstWhere((item) => item.productId == product.id).count += 1;
    } else {
      // var cartItemPrice = product.giaSanPham ?? 0.0;
      // if (product.giamGia != null && product.giamGia! > 0) {
      //   cartItemPrice = cartItemPrice * (100 - product.giamGia!) / 100;
      // }
      _items.add(Cart(
          image: product.image ?? "",
          productId: product.id!,
          name: product.tenSanPham ?? "",
          price: product.giaSanPham?.toDouble()??0,
          count: 1));
      notifyListeners();
    }
  }

  void addMoreToCart(int productId, {bool isIncrement = true}) {
    if (isIncrement) {
      _items.firstWhere((item) => item.productId == productId).count += 1;
    } else {
      if (_items.firstWhere((item) => item.productId == productId).count > 1) {
        _items.firstWhere((item) => item.productId == productId).count -= 1;
      } else {
        _items = _items.where((item) => item.productId != productId).toList();
      }
    }
    notifyListeners();
  }

  void removeFromCart(int productId) async {
    _items = _items.where((item) => item.productId != productId).toList();
    notifyListeners();
  }

  void clearCart({List<int>? ids}) {
    if (ids == null || ids.isEmpty) {
      _items.clear();
    } else {
      _items = _items.where((item) => !ids.contains(item.productId)).toList();
    }
    notifyListeners();
  }
}
