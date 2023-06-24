import 'package:ecommerce_app_flutter/models/danh_muc_san_pham.dart';
import 'package:ecommerce_app_flutter/models/san_pham.dart';
import 'package:ecommerce_app_flutter/provider/danhMucProvider.dart';
import 'package:ecommerce_app_flutter/provider/sanPhamProvider.dart';
import 'package:flutter/material.dart';

import '../components/details_screen_sections.dart';
import '../utils/app_colors.dart';
import '../utils/common.dart';
import '../utils/dimension.dart';
import '../utils/helper.dart';
import '../widgets/small_text.dart';

class DetailProductScreen extends StatefulWidget {
  static const String routeName = "/product_detail";
  const DetailProductScreen({Key? key}) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {

  SanPham productDetail = SanPham();
  DanhMucSanPham danhMucDetail = DanhMucSanPham();
  int idSanPham = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      var id = ModalRoute.of(context)!.settings.arguments as int;
      idSanPham = id;
      var sanPham = await ProductProvider.getDetailProduct(idSanPham);
      var danhMuc = await CategoryProvider.getDetailCategory(sanPham.idDanhMuc??0);
      setState(() {
        productDetail = sanPham;
        danhMucDetail = danhMuc;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.network(
            'https://media.istockphoto.com/photos/cup-of-cafe-latte-with-coffee-beans-and-cinnamon-sticks-picture-id505168330?b=1&k=20&m=505168330&s=170667a&w=0&h=jJTePtpYZLR3M2OULX5yoARW7deTuAUlwpAoS4OriJg=',
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            fit: BoxFit.cover),
        DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.8,
            builder: (context, controller) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(25)),
                child: ListView(
                  controller: controller,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.getScaleWidth(30),
                        right: Dimensions.getScaleWidth(30),
                        top: Dimensions.getScaleHeight(30),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${danhMucDetail.tenDanhMuc}',
                              style: const TextStyle(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          const Text('|',
                              style: TextStyle(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          Text('${danhMucDetail.moTa}',
                              style: const TextStyle(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 20, bottom: 10),
                      child: Text("${productDetail.tenSanPham}",
                          style: const TextStyle(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 22)),
                    ),
                    const SizeListSection(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.getScaleWidth(30),
                        top: Dimensions.getScaleHeight(10),
                      ),
                      child: const Text("Chi tiết",
                          style: TextStyle(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 22)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.getScaleWidth(30),
                          top: Dimensions.getScaleHeight(10),
                          bottom: Dimensions.getScaleHeight(10),
                          right: Dimensions.getScaleWidth(30)),
                      child: Text(
                          "${productDetail.moTa}",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16)),
                    ),
                    Container(
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
                              text: '    ${StringUtils.convertVnCurrency(productDetail.giaSanPham?.toDouble()??0)}',
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              size: 16
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        Positioned(
            top: 25,
            right: 15,
            child: IconButton(
              onPressed: () {

              },
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.black,
                ),
              ),
            )),
        Positioned(
            top: 25,
            left: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ))
      ]),
    );
  }
}
