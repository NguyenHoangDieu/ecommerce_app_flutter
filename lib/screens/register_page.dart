import 'dart:convert';

import 'package:ecommerce_app_flutter/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../provider/userProvider.dart';
import '../utils/app_colors.dart';
import '../utils/dimension.dart';
import '../widgets/share_widget.dart';
import '../widgets/small_text.dart';
import 'home_page.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool executing = false;
  final formKey = GlobalKey<FormState>();
  final controller = PageController();
  @override
  void initState(){
    super.initState();

  }

  onRegister() async {
    var isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      executing = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    var result = false;
    var data = User();
    data.username = userNameController.text;
    data.password = passwordController.text;
    data.hoVaTen = nameController.text;
    data.dienThoai = phoneController.text;
    var dataUser = await UserProvider.registerUser(data);
    if(dataUser.id != 0 || dataUser.id != null){
      result = true;
    }
    setState(() {
      executing = false;
    });
    SharedWidget.showNotifToast(
        result
            ? 'Đăng ký thành công'
            : 'Đăng ký thất bại',
        isSucceed: result);
    await Future.delayed(const Duration(seconds: 1));
    if(result == true){
      if (context.mounted) {
        Navigator.pushNamed(context, LoginScreen.routeName);
        // Navigator.popAndPushNamed(context, HomePageScreen.routeName);
      }
    }
  }

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
        child: ListView(
          children: [
            SizedBox(
              height: Dimensions.getScaleHeight(40),
            ),
            Image.asset(
              'assets/coffee.png',
              width: size.width / 2,
              height: Dimensions.getScaleHeight(200),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [

                CustomText(
                  text: "D-Coffee",
                  fontWeight: FontWeight.w900,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
                CustomText(
                  text: "Enjoy your life with beautiful!",
                  fontWeight: FontWeight.bold,
                  size: 25,
                  color: AppColors.primaryColor,
                ),
              ],
            ),

            SizedBox(
              height: Dimensions.getScaleHeight(30),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: Dimensions.getScaleWidth(300),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập họ và tên';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1,
                              fontSize: Dimensions.getScaleHeight(18),
                              color: AppColors.mainAppColor),
                          decoration: InputDecoration(
                              hintText: 'Họ và tên',
                              filled: true,
                              fillColor: AppColors.mainAppTextWhite.withOpacity(0.6),
                              hintStyle: TextStyle(
                                  color: AppColors.mainAppColor.withOpacity(0.5),
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
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số điện thoại';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1,
                              fontSize: Dimensions.getScaleHeight(18),
                              color: AppColors.mainAppColor),
                          decoration: InputDecoration(
                              hintText: 'Số điện thoại',
                              filled: true,
                              fillColor: AppColors.mainAppTextWhite.withOpacity(0.6),
                              hintStyle: TextStyle(
                                  color: AppColors.mainAppColor.withOpacity(0.5),
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
                                  color: AppColors.mainAppColor.withOpacity(0.5),
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
                                  // fontWeight: FontWeight.bold,
                                  color: AppColors.mainAppColor.withOpacity(0.5),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Dimensions.getScaleWidth(120),
                          height: Dimensions.getScaleHeight(60),
                          child: GestureDetector(
                            onTap: () {
                              onRegister();
                            },
                            child: Container(
                              // margin: const EdgeInsets.only(left: 30, right: 30),
                              alignment: Alignment.center,
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.mainAppColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const CustomText(
                                  text: 'Đăng ký',
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  size: 18
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),

          ],
        ),
      ),
    );
  }
}
