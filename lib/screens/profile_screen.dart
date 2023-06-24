import 'package:ecommerce_app_flutter/models/user.dart';
import 'package:ecommerce_app_flutter/provider/userProvider.dart';
import 'package:ecommerce_app_flutter/utils/dimension.dart';
import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/helper.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User userInfo = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      var localUser = await Helper.getCurrentUser();
      var info = await UserProvider.profileUser(localUser.id??0, localUser.token??'');
      setState(() {
        userInfo = info;
      });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: Dimensions.screenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/wallpaper.jpg'))),
        padding: EdgeInsets.only(
          top: Dimensions.getScaleHeight(20),
          left: Dimensions.getScaleWidth(10)
        ),
        child: Column(
          children: [
            CustomText(text: userInfo.hoVaTen??'Vui lòng đăng nhập'),
            CustomText(text: userInfo.dienThoai??"Vui lòng đăng nhập"),
            CustomText(text: userInfo.username??"Vui lòng đăng nhập"),
            CustomText(text: userInfo.password??"Vui lòng đăng nhập")
          ],
        ),
      ),
    );
  }
}
