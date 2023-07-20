import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../models/san_pham.dart';
import '../../models/user.dart';
import '../../provider/donHangProvider.dart';
import '../../provider/sanPhamProvider.dart';
import '../../state_maneger/cart_changeNotifier.dart';
import '../../state_maneger/user_changeNotifier.dart';
import '../../utils/app_colors.dart';
import '../../utils/common.dart';
import '../../utils/dimension.dart';
import '../../utils/helper.dart';
import '../../widgets/devider_widget.dart';
import '../../widgets/loading_center_widget.dart';
import '../../widgets/share_widget.dart';
import '../../widgets/small_text.dart';
import 'cart_sqflte.dart';
import 'cart_success_page.dart';

class CartConfirmPage extends StatefulWidget {
  static const routeName = "/cart_confirm_screen";
  const CartConfirmPage({super.key});

  @override
  State<CartConfirmPage> createState() => _CartConfirmPageState();
}

class _CartConfirmPageState extends State<CartConfirmPage> {
  int? deliveryMethod = 1;
  double totalOrderPrice = 0.0;
  double tempOrderPrice = 0.0;
  var executing = false;
  User currentUser = User();
  var loading = true;
  var processingOrder = false;
  var calculatingFee = false;
  String api = '';
  SanPham productItem = SanPham();
  List<SanPham> listProduct = [];
  List<Cart> listId = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var data = ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      listId = data['idListItemChecked'] as List<Cart>;
      deliveryMethod = data['deliveryMethod'] as int;
      api = await Services.getApiLink();
      currentUser = await Helper.getCurrentUser();
      for (var item in listId) {
        SanPham apiProducts = await ProductProvider.getDetailProduct(item.productId);
        listProduct.add(apiProducts);
      }
      loading = false;
      setState(() {
        deliveryMethod;
      });
      onCalculateOrderPrice();
    });
  }

  @override
  void dispose() async {
    super.dispose();
  }
  onCalculateOrderPrice() {
    var total = 0.0;
    for (var item in listId) {

      total += item.count * item.price;
    }
    setState(() {
      tempOrderPrice = total;
    });

    setState(() {
      totalOrderPrice = total;
    });
  }
  //tạo đơn hàng
  Future<void> onOrdering(List<Cart> carts) async {
    setState(() {
      processingOrder = true;
    });
    await Future.delayed(const Duration(milliseconds: 2000));

    var orderResult = await DonHangProvider.onDatHang(
        currentUser,
        "Nhận hàng tại nơi bán",
        "75 Đại La",
        carts,
        totalOrderPrice,
        tempOrderPrice
    );
    setState(() {
      processingOrder = false;
    });

    if (orderResult == 0) {
      SharedWidget.showNotifToast('Đặt hàng thất bại', isSucceed: false);
      return;
    }
    await CartSqlite.deleteCarts(currentUser.id!).then((result) {
      Provider.of<CartChangeNotifier>(context, listen: false).clearCart();
    });
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, CartSuccessPage.routeName, (Route<dynamic> route) => false, arguments: orderResult);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer2<CartChangeNotifier, UserChangeNotifier>(
        builder: (context, cartNotif, userNotif, child) {
          return Scaffold(
            appBar: SharedWidget.getAppBar('xác nhận đơn hàng', context),
            body: loading
                ? const LoadingCenterWidget()
                : executing
                ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                ),
                child: const SimpleDialog(
                  children: [
                    Center(
                        child: LoadingCenterWidget(title: '... Đang xử lý'))
                  ],
                ))
                : Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding:
                  EdgeInsets.all(Dimensions.getScaleHeight(16.0)),
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.local_shipping,
                          color: AppColors.mainAppColor,
                        ),
                        CustomText(
                          text: '  Giao hàng',
                          color: AppColors.mainAppColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.getScaleHeight(16),
                          vertical: Dimensions.getScaleHeight(12)),
                      margin: EdgeInsets.only(
                          bottom: Dimensions.getScaleHeight(20),
                          top: Dimensions.getScaleHeight(10)
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: Dimensions.getScaleHeight(120),
                      decoration: BoxDecoration(
                        color: AppColors.silver,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Content
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CustomText(
                                text: 'Phương thức nhận hàng: ',
                                color: AppColors.mainAppColor,
                                fontWeight: FontWeight.w600,
                                size: 14,
                              ),
                              CustomText(
                                text: 'Nhận hàng tại nơi bán',
                                color: AppColors.mainAppColor,
                                size: 14,
                              ),
                            ],
                          ),
                          const DividerWidget(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CustomText(
                                text: 'Địa điểm nhận hàng: ',
                                color: AppColors.mainAppColor,
                                fontWeight: FontWeight.w600,
                                size: 14,
                              ),
                              CustomText(
                                text: '75 Đại La',
                                color: AppColors.mainAppColor,
                                size: 14,
                              ),
                            ],
                          ),
                          const DividerWidget(),
                              const CustomText(
                                text: 'Hiện tại chúng tôi chỉ thanh toán bằng tiền mặt tại cửa hàng!',
                                color: Colors.red,
                                size: 14,
                              ),
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.info,
                          color: AppColors.mainAppColor,
                        ),
                        CustomText(
                          text: '  Thông tin người nhận',
                          color: AppColors.mainAppColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.getScaleHeight(16),
                          vertical: Dimensions.getScaleHeight(12)),
                      margin: EdgeInsets.only(
                          bottom: Dimensions.getScaleHeight(20),
                          top: Dimensions.getScaleHeight(10)
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: Dimensions.getScaleHeight(75),
                      decoration: BoxDecoration(
                        color: AppColors.silver,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Content
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: 'Họ và tên: ',
                                color: AppColors.mainAppColor,
                                fontWeight: FontWeight.w600,
                                size: 14,
                              ),
                              CustomText(
                                text: '${currentUser.hoVaTen}',
                                color: AppColors.mainAppColor,
                                size: 14,
                              ),
                            ],
                          ),
                          const DividerWidget(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: 'Số điện thoại: ',
                                color: AppColors.mainAppColor,
                                fontWeight: FontWeight.w600,
                                size: 14,
                              ),
                              CustomText(
                                text: '${currentUser.dienThoai}',
                                color: AppColors.mainAppColor,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //danh sách chi tiết sản phẩm trong đơn hàng
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                              height: Dimensions.getScaleHeight(20.0));
                        },
                        itemCount: listId.length,
                        itemBuilder: (context, index) {
                          var cartItem = listId[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: Dimensions.getScaleHeight(110.0),
                            padding: EdgeInsets.only(
                                left: Dimensions.getScaleHeight(20),
                                right: Dimensions.getScaleHeight(20),
                                top: Dimensions.getScaleHeight(20),
                                bottom: Dimensions.getScaleHeight(20)),
                            decoration: BoxDecoration(
                              color: AppColors.mainAppColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.silver,
                                  width: Dimensions.getScaleHeight(1.0)),
                            ),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: Dimensions.getScaleWidth(80),
                                    height: Dimensions.getScaleHeight(80),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.silver),
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '$api${cartItem.image}'),
                                      ),
                                    )),
                                const DividerWidget(size: 20,isVertical: false),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          maxLines: 1,
                                          size: 13,
                                          text: 'Tên sản phẩm: ${cartItem.name}',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.whiteColor,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              maxLines: 1,
                                              size: 12,
                                              text:
                                              "Số lượng: ${StringUtils.padLeftZero(cartItem.count)}",
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColor,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomText(
                                              maxLines: 1,
                                              text: "TỔNG:",
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.whiteColor,
                                            ),
                                            CustomText(
                                              maxLines: 1,
                                              text: StringUtils.convertVnCurrency(cartItem.price * cartItem.count),
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.whiteColor,
                                            ),
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          );
                        }),
                  ],
                ),
                if (processingOrder)
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                      ),
                      child: const SimpleDialog(
                        children: [
                          Center(
                              child: LoadingCenterWidget(
                                  title: '... Đang xử lý'))
                        ],
                      ))
              ],
            ),
            bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(Dimensions.getScaleHeight(16)),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: AppColors.silver,
                          width: Dimensions.getScaleHeight(1)))),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getScaleHeight(36),
                      vertical: Dimensions.getScaleHeight(18)),
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.getScaleHeight(16))),
                  elevation: 0,
                ),
                onPressed: cartNotif.items.isNotEmpty && processingOrder == false
                    ? () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                            title: const CustomText(
                              text: 'XÁC NHẬN ĐẶT HÀNG',
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                              color: AppColors.mainAppColor,
                              size: 22,
                            ),
                            actions: [
                              TextButton(
                                child: const CustomText(
                                    text: 'Đồng ý',
                                  color: Colors.green,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  onOrdering(listId);
                                },
                              ),
                              TextButton(
                                child: const CustomText(
                                    text: 'Hủy bỏ',
                                    color: Colors.red,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ]);
                      });
                }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 6,
                      child: CustomText(
                        text: 'Đặt hàng',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        size: Dimensions.getScaleHeight(18),
                      ),
                    ),
                    Container(
                      width: Dimensions.getScaleHeight(2),
                      height: Dimensions.getScaleHeight(26),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    if (listId.isNotEmpty)
                      Flexible(
                        flex: 6,
                        child: CustomText(
                          text: StringUtils.convertVnCurrency(totalOrderPrice),
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          size: Dimensions.getScaleHeight(14),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}