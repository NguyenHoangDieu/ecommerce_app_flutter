import 'dart:convert';
import 'package:ecommerce_app_flutter/models/san_pham.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/cart.dart';
import '../../models/user.dart';
import '../../utils/helper.dart';

class CartSqlite {
  static const _dbName = "cart.db";
  static Future<Database> getDatabase() async {
    var databasePath = await getDatabasesPath();
    var path = "$databasePath/$_dbName";
    var database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          var sql =
              "CREATE TABLE Cart (id INTEGER PRIMARY KEY, userId INT, productId INT, image TEXT,  name TEXT, price DOUBLE, count INT)";
          await db.execute(sql);
        });
    return database;
  }

  static Future<List<Cart>> getCarts({int userId = 0}) async {
    List<Cart> carts = [];
    try {
      if (userId == 0) {
        var json = await Helper.getUserPrefs();
        var user = User.fromLocalCache(jsonDecode(json));
        userId = user.id ?? 0;
      }

      var db = await getDatabase();
      var sql = "SELECT * FROM Cart WHERE userId = $userId";
      var dbCarts = await db.rawQuery(sql);
      if (dbCarts.isNotEmpty) {
        for (var item in dbCarts) {
          var productId = item['productId'] as int;
          var name = item['name'] as String;
          var image = item['image'] as String;
          var price = item['price'] as double;
          var count = item['count'] as int;
          carts.add(Cart(
              productId: productId,
              image: image,
              name: name,
              price: price,
              count: count));
        }
      }
      db.close();
    } catch (e) {
      //print e
    }
    return carts;
  }

  static Future<int> addToCart(SanPham product, int userId) async {
    int updatedRows = -1;
    try {
      var db = await getDatabase();
      //kiểm tra xem giỏ hàng đã có sản phẩm chưa
      var dbCarts = await db.rawQuery(
          "SELECT * FROM Cart WHERE productId = ${product.id} AND userId = $userId");
      if (dbCarts.isEmpty) {
        await db.transaction((txn) async {
          var sql = 'INSERT INTO Cart (productId, image, name, price, count, userId) VALUES(${product.id}, "${product.image}", "${product.tenSanPham}", ${product.giaSanPham}, 1, $userId)';
          updatedRows = await txn.rawInsert(sql);
        });
      } else {
        var firstRow = dbCarts[0];
        var cartId = firstRow['id'] as int;
        var count = firstRow['count'] as int;

        await db.transaction((txn) async {
          var sql = 'UPDATE Cart SET count = ${(count + 1)} WHERE id = $cartId';
          updatedRows = await txn.rawUpdate(sql);
        });
      }
      db.close();
    } catch (e) {
      //print
    }
    return updatedRows;
  }

  static Future<int> updateQuantity(int productId, int userId,
      {bool isIncrement = true}) async {
    var updatedRows = -1;
    try {
      var db = await getDatabase();
      var dbCarts = await db.rawQuery(
          "SELECT * FROM Cart WHERE productId = $productId AND userId = $userId");
      if (dbCarts.isNotEmpty) {
        var firstRow = dbCarts[0];
        var cartId = firstRow['id'] as int;
        var count = firstRow['count'] as int;
        if (isIncrement) {
          count += 1;
        } else {
          count -= 1;
        }
        var sql = 'UPDATE Cart SET count = $count WHERE id = $cartId';
        if (count == 0) {
          sql = 'DELETE FROM Cart WHERE id = $cartId';
        }
        await db.transaction((txn) async {
          if (count == 0) {
            updatedRows = await txn.rawDelete(sql);
          } else {
            updatedRows = await txn.rawUpdate(sql);
          }
        });
      }
      db.close();
    } catch (e) {
      //print
    }
    return updatedRows;
  }

  static Future<int> removeMultipleFromCart(
      List<int> productIds, int userId) async {
    var updatedRows = -1;
    try {
      var db = await getDatabase();
      var ids = productIds.join(", ");
      var dbCarts = await db.rawQuery(
          "SELECT * FROM Cart WHERE productId IN ($ids) AND userId = $userId");
      if (dbCarts.isNotEmpty) {
        var sql =
            'DELETE FROM Cart WHERE productId IN ($ids) AND userId = $userId';
        await db.transaction((txn) async {
          updatedRows = await txn.rawDelete(sql);
        });
      }
      db.close();
    } catch (e) {
      //print
    }
    return updatedRows;
  }

  static Future<int> removeFromCart(int productId, int userId) async {
    var updatedRows = -1;
    try {
      var db = await getDatabase();
      var dbCarts = await db.rawQuery(
          "SELECT * FROM Cart WHERE productId = $productId AND userId = $userId");
      if (dbCarts.isNotEmpty) {
        var firstRow = dbCarts[0];
        var cartId = firstRow['id'] as int;
        var sql = 'DELETE FROM Cart WHERE id = $cartId';
        await db.transaction((txn) async {
          updatedRows = await txn.rawDelete(sql);
        });
      }
      db.close();
    } catch (e) {
      //print
    }
    return updatedRows;
  }

  //xóa giỏ hàng
  static Future<int> deleteCarts(int userId) async {
    var updatedRows = -1;
    try {
      var db = await getDatabase();
      var sql = 'DELETE FROM Cart WHERE userId = $userId';
      await db.transaction((txn) async {
        updatedRows = await txn.rawDelete(sql);
      });
      db.close();
    } catch (e) {
      //print
    }
    return updatedRows;
  }
}
