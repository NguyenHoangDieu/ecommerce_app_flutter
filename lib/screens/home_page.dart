import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app_flutter/models/danh_muc_san_pham.dart';
import 'package:ecommerce_app_flutter/models/user.dart';
import 'package:ecommerce_app_flutter/provider/danhMucProvider.dart';
import 'package:ecommerce_app_flutter/provider/userProvider.dart';
import 'package:ecommerce_app_flutter/screens/cart/cart_page.dart';
import 'package:ecommerce_app_flutter/screens/detail_product.dart';
import 'package:ecommerce_app_flutter/screens/product_list_page.dart';
import 'package:ecommerce_app_flutter/screens/profile_screen.dart';
import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/utils/helper.dart';
import 'package:ecommerce_app_flutter/widgets/loading_center_widget.dart';
import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/home_header.dart';
import '../components/search_bar.dart';
import '../components/special_card.dart';
import '../models/san_pham.dart';
import '../provider/sanPhamProvider.dart';
import '../utils/common.dart';
import '../utils/dimension.dart';
import 'bill/bill_list_page.dart';
import 'login_page.dart';

final List<String> imagesList = [
  'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/09/15/26/christmas-1895061_1280.jpg',
  'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
  'https://cdn.pixabay.com/photo/2017/04/04/18/07/ice-cream-2202561_1280.jpg',
];

class HomePageScreen extends StatefulWidget {
  static const String routeName = "/home_page";
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedScreenIndex = 0;
  int _currentIndex = 0;
  List<SanPham> _listProducts = [];
  bool loading = true;
  List<DanhMucSanPham> _listCategory = <DanhMucSanPham>[];
  int idDanhMuc = 0;
  String api = '';
  int _currentPage = 0;
  User currentUser = User();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      currentUser = await UserProvider.profileUser(currUser.id??0, currUser.token??'');
      api = await Services.getApiLink();
      _listCategory = await CategoryProvider.fetchListDanhMuc();
      await productFetchListByCategory(idDanhMuc);
      setState(() {
        loading = false;
        _currentPage;
        if(_listCategory.isNotEmpty){
          _currentPage = 0;
          idDanhMuc = _listCategory[_currentPage].id!;
          productFetchListByCategory(idDanhMuc);
          print(currUser.id);
        }
      });
    });
  }


  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }

  void onTapHandler(int index)  {
    setState(() {
      _selectedScreenIndex = index;
    });
    switch(_selectedScreenIndex){
      case 0 : Navigator.pushNamed(context, HomePageScreen.routeName, arguments: currentUser);
      break;
      case 1 : Navigator.pushNamed(context, ProductListScreen.routeName);
      break;
      case 2 : currentUser.id != null ?
          Navigator.pushNamed(context, ProfileScreen.routeName, arguments: currentUser.id):
      Navigator.pushNamed(context, LoginScreen.routeName);
      break;
  }
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
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(
            top: Dimensions.getScaleHeight(20),
            left: Dimensions.getScaleWidth(10),
            right: Dimensions.getScaleWidth(45),
          ),
          color: AppColors.mainAppColor,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only( left: Dimensions.getScaleWidth(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1640915550677-26ade06905fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzN3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
                      child: InkWell(
                          onTap: (){
                            currentUser.id != null?
                            Navigator.pushNamed(context, ProfileScreen.routeName, arguments: currentUser.id):
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                         ),
                    ),
                    SizedBox(
                      height: Dimensions.getScaleHeight(10),
                    ),
                    CustomText(
                      text: currentUser.hoVaTen??"Khách hàng",
                      color: Colors.white,

                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.getScaleHeight(20)),
              const Divider(thickness: 1,color: Colors.white,),
              buildMenuItem(
                  text: 'Cá nhân',
                  icon: Icons.person_outline_outlined,
                  onClick: (){
                    currentUser.id != null?
                        Navigator.pushNamed(context, ProfileScreen.routeName, arguments: currentUser.id):
                        Navigator.pushNamed(context, LoginScreen.routeName);
                  }
              ),
              buildMenuItem(
                  text: 'Sản phẩm',
                  icon: Icons.coffee,
                  onClick: (){
                    Navigator.pushNamed(context, ProductListScreen.routeName);
                  }
              ),
              buildMenuItem(
                  text: 'Giỏ hàng',
                  icon: Icons.shopping_cart,
                  onClick: (){
                    Navigator.pushNamed(context, CartPage.routeName);
                  }
              ),
              buildMenuItem(
                  text: 'Đơn hàng',
                  icon: Icons.file_copy,
                  onClick: (){
                    Navigator.pushNamed(context, ListOrderScreen.routeName);
                  }
              ),
              const Divider(thickness: 1,color: Colors.white,),
              currentUser.id == null ?
              buildMenuItem(
                  text: 'Đăng nhập',
                  icon: Icons.login,
                  onClick: (){
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  }
              ):
              buildMenuItem(
                  text: 'Đăng xuất',
                  icon: Icons.logout,
                  onClick: (){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text(
                                'ĐĂNG XUẤT KHỎI HỆ THỐNG'),
                            content: const Text(
                                'Bạn có chắc chắn không?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Không',
                                    style: TextStyle(
                                        color: AppColors
                                            .mainAppColor)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors
                                      .mainAppColor,
                                ),
                                onPressed: () {
                                  Helper.onSignOut(context);
                                },
                                child: const Text('Có'),
                              ),
                            ],
                          ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: (int index) {
          onTapHandler(index);
        },
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
                'assets/coffee-svgrepo-com.svg',
                height: 28,
              ),
              label: 'Sản phẩm'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/profile-svgrepo-com.svg',
                height: 28,
              ),
              label: 'Cá nhân'),
        ],
      ),
      body: loading?
      const LoadingCenterWidget() :
      ListView(
        children: [
          const Header(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: CustomText(
              text: 'D-Coffee chào buổi sáng! ',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  size: 24
            ),
          ),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  // enlargeCenterPage: true,
                  //scrollDirection: Axis.vertical,
                  onPageChanged: (index, reason) {
                    setState(
                          () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: imagesList.map((item) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      elevation: 6.0,
                      shadowColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagesList.map((urlOfItem) {
                  int index = imagesList.indexOf(urlOfItem);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? AppColors.mainAppColor
                          : AppColors.mainAppColorLight,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
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
                              color: selected ? AppColors.whiteColor : Colors.black),
                        )
                      ],
                    ),
                  ),
                );

              },

            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.getScaleWidth(20)),
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
                          mainAxisExtent: Dimensions.getScaleWidth(300),
                          crossAxisCount: 2),
                      itemBuilder: (context,index){
                        var product = _listProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, DetailProductScreen.routeName, arguments: product.id);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: Dimensions.getScaleWidth(20),
                                bottom: Dimensions.getScaleHeight(20)),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mainAppColorLight.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                              color: AppColors.greyLight,
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
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '$api${product.image}'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                                      child: CustomText(
                                          text: '${product.tenSanPham}',
                                          size: 16,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: Dimensions.getScaleWidth(8.0), bottom: Dimensions.getScaleHeight(5.0)),
                                      child: CustomText(
                                        text: '${product.moTa}',
                                        size: 12,
                                        fontWeight: FontWeight.w400,
                                        maxLines: 3,
                                        color: AppColors.mainAppColor.withOpacity(0.7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text: StringUtils.convertVnCurrency(product.giaSanPham?.toDouble()??0),
                                        size: 18,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.mainAppColor,
                                      ),
                                    ),
                                  ],
                                ),
                                // const Positioned(
                                //     bottom: 8,
                                //     right: 8,
                                //     child: CircleAvatar(
                                //         backgroundColor: AppColors.mainAppColorLight,
                                //         child: Icon(Icons.add, color: AppColors.mainAppTextWhite,))),
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

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClick
}){
  const color = Colors.white;
  const hoverColor = Colors.white70;
  return ListTile(
    leading: Icon(icon, color: color,),
    title: CustomText(
      text: text,
      color: color,
    ),
    hoverColor: hoverColor,
    onTap: onClick,
  );
}
