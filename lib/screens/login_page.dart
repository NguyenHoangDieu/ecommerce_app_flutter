import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/image_slider.dart';
import '../utils/app_colors.dart';
import '../utils/dimension.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: Dimensions.screenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/wallpaper.jpg'))),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.getScaleHeight(60),
            ),
            Image.asset(
              'assets/coffee.png',
              width: size.width / 1.5,
            ),
            SizedBox(
              height: Dimensions.getScaleHeight(20),
            ),
           SizedBox(
             width: Dimensions.getScaleWidth(300),
             child: TextFormField(
                 textAlignVertical: TextAlignVertical.center,
                 controller: userNameController,
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Vui lòng nhập tên đăng nhập';
                   }
                   return null;
                 },
                 textAlign: TextAlign.center,
                 style: TextStyle(
                     height: 1,
                     fontSize: Dimensions.getScaleHeight(18),
                     color: AppColors.mainAppColor),
                 decoration: InputDecoration(
                     hintText: 'Tên đăng nhập',
                     filled: true,
                     fillColor: AppColors.mainAppTextWhite.withOpacity(0.6),
                     hintStyle: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: AppColors.mainAppColor,
                         fontSize: Dimensions.getScaleHeight(18.0)),
                     alignLabelWithHint: true,
                     border: const OutlineInputBorder(
                       borderRadius:
                       BorderRadius.all(Radius.circular(45)),
                     ))),
           ),
           SizedBox(
             height: Dimensions.getScaleHeight(20),
           ),
           SizedBox(
             width: Dimensions.getScaleWidth(300),
             child: TextFormField(
                 textAlignVertical: TextAlignVertical.center,
                 controller: passwordController,
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Vui lòng nhập mật khẩu';
                   }
                   return null;
                 },
                 textAlign: TextAlign.center,
                 style: TextStyle(
                     height: 1,
                     fontSize: Dimensions.getScaleHeight(18),
                     color: AppColors.mainAppColor),
                 decoration: InputDecoration(
                     hintText: 'Mật khẩu',
                     filled: true,
                     fillColor: AppColors.mainAppTextWhite.withOpacity(0.6),
                     hintStyle: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: AppColors.mainAppColor,
                         fontSize: Dimensions.getScaleHeight(18.0)),
                     alignLabelWithHint: true,
                     border: const OutlineInputBorder(
                       borderRadius:
                       BorderRadius.all(Radius.circular(45)),
                     ))),
           ),
           SizedBox(
             height: Dimensions.getScaleHeight(20),
           ),
           SizedBox(
             width: Dimensions.getScaleWidth(200),
             child: GestureDetector(
               onTap: () {
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) => const HomePageScreen()));
               },
               child: Container(
                 margin: const EdgeInsets.only(left: 30, right: 30),
                 alignment: Alignment.center,
                 height: 60,
                 width: double.infinity,
                 decoration: BoxDecoration(
                     color: AppColors.primaryColor,
                     borderRadius: BorderRadius.circular(30)),
                 child: const CustomText(
                     text: 'Đăng nhập',
                     color: AppColors.whiteColor,
                     fontWeight: FontWeight.w700,
                     size: 20
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
