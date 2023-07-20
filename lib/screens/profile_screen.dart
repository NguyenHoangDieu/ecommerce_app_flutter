import 'package:ecommerce_app_flutter/models/user.dart';
import 'package:ecommerce_app_flutter/provider/userProvider.dart';
import 'package:ecommerce_app_flutter/screens/login_page.dart';
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/utils/dimension.dart';
import 'package:ecommerce_app_flutter/widgets/share_widget.dart';
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
      appBar: SharedWidget.getAppBar('Hồ sơ', context),
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
        child: userInfo.id != null ? Column(
          children: [
            SizedBox(
              height: Dimensions.getScaleHeight(50),
            ),
            const CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1640915550677-26ade06905fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzN3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
            ),
            SizedBox(
              height: Dimensions.getScaleHeight(20),
            ),
            CustomText(
              text: 'Họ và tên: ${userInfo.hoVaTen}',
              size: 22,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: Dimensions.getScaleHeight(20),
            ),
            CustomText(
                text: 'Số điện thoại: ${userInfo.dienThoai}',
              size: 18,
            ),
            SizedBox(
              height: Dimensions.getScaleHeight(10),
            ),
            CustomText(text: 'Username: ${userInfo.username}',
            size: 18,),
          ],
        ) :
        Column(
          children: [
            SizedBox(
              height: Dimensions.getScaleHeight(50),
            ),
            const CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1640915550677-26ade06905fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzN3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
            ),
            SizedBox(
              height: Dimensions.getScaleHeight(30),
            ),
            const CustomText(
                text: 'Vui lòng đăng nhập!',
              color: Colors.red,
              fontWeight: FontWeight.bold,
              size: 20,
            ),
            SizedBox(
              height: Dimensions.getScaleHeight(30),
            ),
            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }, 
                child: Container(
                  alignment: Alignment.center,
                  width: Dimensions.getScaleWidth(120),
                  height: Dimensions.getScaleHeight(80),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.mainAppColor

                  ),
                  child: const CustomText(
                    text: 'ĐĂNG NHẬP',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    size: 16,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
