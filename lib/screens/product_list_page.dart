import 'dart:io';

import 'package:ecommerce_app_flutter/provider/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/san_pham.dart';
import '../models/user.dart';
import '../provider/sanPhamProvider.dart';
import '../utils/api.dart';
import '../utils/app_colors.dart';
import '../utils/common.dart';
import '../utils/dimension.dart';
import '../utils/helper.dart';
import '../widgets/share_widget.dart';
import '../widgets/small_text.dart';
import 'detail_product.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = "/product_list_screen";
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<SanPham> _listProducts = [];
  bool loading = true;
  String? tenSanPham = '';
  String api = '';
  final int _currentPage = 0;
  final _tenSanPhamController = TextEditingController();
  User currentUser = User();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      currentUser = await UserProvider.profileUser(currUser.id??0, currUser.token??'');
      api = await Services.getApiLink();
      await productFetchListBySearch(_tenSanPhamController.text??'');
      setState(() {
        loading = false;
        _currentPage;
      });
    });
  }
  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }
  Future<void> productFetchListBySearch(String? tenSanPham) async {
    try {
      tenSanPham = _tenSanPhamController.text;
      var apiProductPage = await ProductProvider.fetchListProductBySearch(tenSanPham);
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
      appBar: SharedWidget.getAppBar('Sản phẩm', context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _tenSanPhamController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 24,
                  ),
                  hintText: 'Nhập từ khóa cần tìm',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: (){
                        productFetchListBySearch(_tenSanPhamController.text);
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.secondaryColor,
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  enabledBorder:const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5)),
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
                          mainAxisExtent: Dimensions.getScaleWidth(250),
                          crossAxisCount: 2),
                      itemBuilder: (context,index){
                        var product = _listProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, DetailProductScreen.routeName, arguments: product.id);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: Dimensions.getScaleHeight(15)),
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
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '$api${product.image}'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                                      child: CustomText(
                                          text: '${product.tenSanPham}',
                                          size: 16, fontWeight: FontWeight.bold
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
        ],
      ),
    );
  }
}
