
import 'dart:io';

import 'package:ecommerce_app_flutter/models/san_pham.dart';
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/utils/dimension.dart';
import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../provider/sanPhamProvider.dart';
import '../screens/product_detail.dart';
import '../utils/common.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);
  @override
  State<ProductCard> createState() => _ProductCardState();
}
class _ProductCardState extends State<ProductCard> {
  List<SanPham> _listProducts = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await productFetchList();
      setState(() {

      });
    });
  }


  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }
  Future<void> productFetchList() async {
    try {
      var apiProductPage = await ProductProvider.fetchListProduct();
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
    return Expanded(
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

    );
  }
}
