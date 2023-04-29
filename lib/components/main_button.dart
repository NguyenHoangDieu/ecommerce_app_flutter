
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
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
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30)),
        child: const Text('Get Started',
            style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
      ),
    );
  }
}
