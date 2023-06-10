
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            color: AppColors.mainAppColor,
            borderRadius: BorderRadius.circular(30)),
        child: const CustomText(
            text: 'BẮT ĐẦU',
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w700,
            size: 20
        ),
      ),
    );
  }
}
