import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_flutter/models/danh_muc_san_pham.dart';
import 'package:ecommerce_app_flutter/models/san_pham.dart';
import 'package:ecommerce_app_flutter/models/user.dart';
import 'package:ecommerce_app_flutter/provider/danhMucProvider.dart';
import 'package:ecommerce_app_flutter/provider/sanPhamProvider.dart';
import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/details_screen_sections.dart';
import '../state_maneger/cart_changeNotifier.dart';
import '../state_maneger/user_changeNotifier.dart';
import '../utils/app_colors.dart';
import '../utils/common.dart';
import '../utils/dimension.dart';
import '../utils/helper.dart';
import '../widgets/devider_widget.dart';
import '../widgets/share_widget.dart';
import '../widgets/small_text.dart';
import 'cart/cart_page.dart';
import 'cart/cart_sqflte.dart';
import 'login_page.dart';

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
  var user = User();
  String api = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      user = currUser;
      var id = ModalRoute.of(context)!.settings.arguments as int;
      idSanPham = id;
      api = await Services.getApiLink();
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
    return Consumer2<CartChangeNotifier, UserChangeNotifier>(
        builder: (context, cartNotif, userNotif, child)
    {
      return Scaffold(
        body: Stack(children: [
          Image.network(
              '$api${productDetail.image}',
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
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
                        padding: const EdgeInsets.only(
                            left: 30.0, top: 20, bottom: 10),
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
                      InkWell(
                        child: Container(
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
                                  text: '    ${StringUtils.convertVnCurrency(
                                      productDetail.giaSanPham?.toDouble() ?? 0)}',
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  size: 16
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          user.id != null ?
                          CartSqlite.addToCart(productDetail, user.id??0).then((result) {
                            if (result > 0) {
                              cartNotif.addItem(productDetail);
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: Dimensions.getScaleHeight(250.0),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.getScaleWidth(16.0)),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  Dimensions.getScaleHeight(20.0)),
                                              topRight: Radius.circular(
                                                  Dimensions.getScaleHeight(20.0)),
                                            ),
                                            color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: Dimensions.getScaleHeight(20.0)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                      Icons.check_circle_outline,
                                                      size: Dimensions.getScaleWidth(14.0),
                                                      color: Colors.green.shade500),
                                                  DividerWidget(
                                                      isVertical: false,
                                                      size: Dimensions.getScaleWidth(5.0)),
                                                  const CustomText(
                                                      size: 16,
                                                      text: "Đã thêm sản phẩm vào giỏ hàng thành công",
                                                      color: AppColors.primaryColor)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(Dimensions.getScaleWidth(10)),
                                              margin: EdgeInsets.only(
                                                  left: Dimensions.getScaleWidth(20),
                                                  right: Dimensions.getScaleWidth(20)
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.mainAppColor,
                                                border: Border.all(color: AppColors.mainAppColor),
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: Dimensions.getScaleWidth(90),
                                                      height: Dimensions.getScaleHeight(80),
                                                      margin: EdgeInsets.only(
                                                        left: Dimensions.getScaleWidth(20),
                                                        right: Dimensions.getScaleWidth(10)
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.silver,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: AppColors.whiteColor),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage('$api${productDetail.image}'),
                                                        ),
                                                      )),
                                                  // Expanded(
                                                  //   flex: 3,
                                                  //   child: SizedBox(
                                                  //     width: double.infinity,
                                                  //     height: Dimensions.getScaleHeight(70.0),
                                                  //     child: CachedNetworkImage(
                                                  //       imageUrl: '$api${productDetail.image}',
                                                  //       fit: BoxFit.contain,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: Dimensions.getScaleWidth(10.0)),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomText(
                                                              size: 16,
                                                              text: productDetail.tenSanPham ??= "",
                                                            color: AppColors.whiteColor,
                                                          ),
                                                          DividerWidget(
                                                              size: Dimensions
                                                                  .getScaleWidth(
                                                                  10.0)),
                                                            CustomText(
                                                                color: AppColors.whiteColor,
                                                                fontWeight: FontWeight.bold,
                                                                text: StringUtils.convertVnCurrency(productDetail.giaSanPham?.toDouble() ?? 0,
                                                                ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dimensions.getScaleHeight(10),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Dimensions.getScaleWidth(10.0)),
                                              width: Dimensions.getScaleWidth(180),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor: AppColors.mainAppColor,
                                                  backgroundColor: AppColors.primaryColor
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(context, CartPage.routeName, arguments: productDetail.id);
                                                },
                                                child: const CustomText(
                                                    size: 13,
                                                    color: AppColors.mainAppTextWhite,
                                                    text: "Xem giỏ hàng"),
                                              ),
                                            )
                                          ],
                                        ));
                                  });
                            } else {
                              SharedWidget.showNotifToast(
                                  'Có lỗi xảy ra! Vui lòng thử lại sau',
                                  isSucceed: false);
                            }
                          }):
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
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
    });
  }
}
