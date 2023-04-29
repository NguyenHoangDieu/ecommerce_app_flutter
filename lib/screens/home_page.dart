import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/categories.dart';
import '../components/home_header.dart';
import '../components/product_card.dart';
import '../components/search_bar.dart';
import '../components/special_card.dart';
import '../utils/common.dart';
import '../widgets/share_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mainAppColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/home-svgrepo-com.svg',
                color: AppColors.mainAppColor,
                height: 28,
              ),
              label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/favourite-svgrepo-com.svg',
                height: 28,
              ),
              label: 'Yêu thích'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/bag-outline-svgrepo-com.svg',
                height: 28,
              ),
              label: 'Giỏ hàng'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/profile-svgrepo-com.svg',
                height: 28,
              ),
              label: 'Cá nhân'),
        ],
      ),
      body: ListView(
        children: [
          const Header(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: CustomText(
              text: 'D-Coffee chào buổi sáng! ',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  size: 24
            ),
          ),
          const SearchBar(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: CustomText(
              text: 'Danh mục đồ uống',
                color: AppColors.mainAppColor,
                fontWeight: FontWeight.bold,
                size: 24
            ),
          ),
          const Categories(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ProductCard(),
                ProductCard(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: CustomText(
              text: 'Đề xuất cho bạn',
                  color: AppColors.mainAppColor,
                  fontWeight: FontWeight.w900,
                  size: 24
            ),
          ),
          const SpecialOfferCard()
        ],
      ),
    );
  }
}
