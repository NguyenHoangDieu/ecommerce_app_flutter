
import 'dart:ffi';

import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/common.dart';
import '../widgets/small_text.dart';
import 'category_card.dart';

class AddToCartCard extends StatelessWidget {
  const AddToCartCard({
    Key? key,
    required double giaSanPham
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.center,
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Thêm vào giỏ hàng     ',
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          const SizedBox(
              height: 20,
              child: VerticalDivider(
                color: Colors.white,
              )),
          CustomText(
              text: '    ${StringUtils.convertVnCurrency(0.0)}',
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w700,
              size: 16
          ),
        ],
      ),
    );
  }
}

class SizeListSection extends StatelessWidget {
  const SizeListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(
        left: 20.0,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: CategoryItem(
                isSelected: true,
                title: "Size M"),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: CategoryItem(
                isSelected: false,
                title: "Size L"),
          ),
        ],
      ),
    );
  }
}
