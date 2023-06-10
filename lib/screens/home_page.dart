import 'dart:io';

import 'package:ecommerce_app_flutter/models/danh_muc_san_pham.dart';
import 'package:ecommerce_app_flutter/provider/danhMucProvider.dart';
import 'package:ecommerce_app_flutter/screens/product_detail.dart';
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/category_card.dart';
import '../components/home_header.dart';
import '../components/search_bar.dart';
import '../components/special_card.dart';
import '../models/san_pham.dart';
import '../provider/sanPhamProvider.dart';
import '../utils/common.dart';
import '../utils/dimension.dart';
import '../widgets/navigation_drawer_widget.dart';
import '../widgets/share_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<SanPham> _listProducts = [];
  List<DanhMucSanPham> _listCategory = <DanhMucSanPham>[];
  int idDanhMuc = 0;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _listCategory = await CategoryProvider.fetchListDanhMuc();
      await productFetchListByCategory(idDanhMuc);
      setState(() {
        _currentPage;
        if(_listCategory.isNotEmpty){
          _currentPage = 0;
          idDanhMuc = _listCategory[_currentPage].id!;
          productFetchListByCategory(idDanhMuc);
        }
      });
    });
  }


  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }
  Future<void> productFetchListByCategory(int idDanhMuc) async {
    try {
      var apiProductPage = await ProductProvider.fetchListProductByCategory(idDanhMuc);
      var products = apiProductPage;
      setState(() {
        _listProducts = products;
      });
    } on SocketException catch (ex) {
      throw Exception('Failed to load ${ex.message}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
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
              label: 'Trang chủ',
          ),
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
          SizedBox(
            height: 60,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: _listCategory.length,
              itemBuilder: (context, index) {
                var category = _listCategory[index];
                var selected = index == _currentPage;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      idDanhMuc = category.id??0;
                      _currentPage = index;
                      productFetchListByCategory(idDanhMuc);
                      print(_currentPage);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 4, left: 8, top: 4, bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: selected
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.transparent,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: selected ? AppColors.mainAppColorLight : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.coffee),
                        Text(
                          '  ${category.tenDanhMuc}',
                          style: TextStyle(
                              color:
                              selected ? AppColors.whiteColor : Colors.black),
                        )
                      ],
                    ),
                  ),
                );

              },

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      // controller: _scrollController,
                      itemCount: _listProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 0,
                          mainAxisExtent: Dimensions.getScaleWidth(350),
                          crossAxisCount: 2),
                      itemBuilder: (context,index){
                        var product = _listProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProducDetailsScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 8,
                                  offset: const Offset(3, 5),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            padding: const EdgeInsets.all(4),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(4),
                                      height: MediaQuery.of(context).size.width / 2 - 48,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'https://media.istockphoto.com/photos/cup-of-cafe-latte-with-coffee-beans-and-cinnamon-sticks-picture-id505168330?b=1&k=20&m=505168330&s=170667a&w=0&h=jJTePtpYZLR3M2OULX5yoARW7deTuAUlwpAoS4OriJg='))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                                      child: CustomText(
                                          text: '${product.tenSanPham}',
                                          size: 16, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: Dimensions.getScaleWidth(8.0), bottom: Dimensions.getScaleHeight(15.0)),
                                      child: CustomText(
                                          text: '${product.moTa}',
                                          size: 12, fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text: StringUtils.convertVnCurrency(product.giaSanPham?.toDouble()??0),
                                        size: 18,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.mainAppColorLight,
                                      ),
                                    ),
                                  ],
                                ),
                                const Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: CircleAvatar(
                                        backgroundColor: AppColors.mainAppColorLight,
                                        child: Icon(Icons.add, color: AppColors.mainAppTextWhite,))),
                                Positioned(
                                    top: 14,
                                    right: 14,
                                    child: Container(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.mainAppColorLight.withOpacity(.8),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.star, color: Colors.yellow, size: 14,),
                                          Text(
                                            ' 4,5',
                                            style: TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      }),

                )
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
