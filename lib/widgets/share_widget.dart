import 'package:appbar_animated/appbar_animated.dart';
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SharedWidget {
  static PreferredSizeWidget getAppBar(String title, BuildContext context, ColorAnimated colorAnimated,
      {void Function()? onSearchPress}) {
    return AppBar(
      title: Text(title.toUpperCase()),
      leading: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: colorAnimated.color,
      ),
      backgroundColor: colorAnimated.background,
      actions: [
        if (onSearchPress != null)
          IconButton(icon: const Icon(Icons.search), onPressed: onSearchPress),
        IconButton(
          icon: const Icon(
            Icons.home,
            size: 26,
          ),
          onPressed: () async {

          },
        ),
        const SizedBox(width: 20)
      ],
    );
  }

  static void showNotifToast(String message, {bool isSucceed = true}) {
    Fluttertoast.showToast(
        backgroundColor: isSucceed ? Colors.green : Colors.red,
        textColor: Colors.white,
        msg: message);
  }
}