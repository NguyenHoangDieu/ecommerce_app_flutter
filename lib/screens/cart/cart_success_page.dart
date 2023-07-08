import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/dimension.dart';
import '../../widgets/share_widget.dart';
import '../../widgets/small_text.dart';

class CartSuccessPage extends StatefulWidget {
  static const routeName = "/cart_success_screen";
  const CartSuccessPage({super.key});

  @override
  State<CartSuccessPage> createState() => _CartSuccessPageState();
}

class _CartSuccessPageState extends State<CartSuccessPage> {
  var orderId = 0;
  @override
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        orderId = ModalRoute.of(context)!.settings.arguments as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidget.getAppBar('đặt hàng', context),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: Dimensions.getScaleHeight(200.0),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.getScaleHeight(16),
            vertical: Dimensions.getScaleHeight(24)),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: Dimensions.getScaleHeight(16)),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, DetailDonHangScreen.routeName, arguments: orderId);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.mainAppColor,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.getScaleHeight(18)),
                    backgroundColor: AppColors.silver,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.getScaleHeight(16))),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: const CustomText(
                      text: 'Xem đơn hàng',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, ProductIndexPage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.getScaleHeight(18)),
                  backgroundColor: AppColors.mainAppColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(Dimensions.getScaleHeight(16))),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: const CustomText(
                    text: 'Tiếp tục mua sắm',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    size: 18),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Dimensions.getScaleHeight(124),
              height: Dimensions.getScaleHeight(124),
              margin: EdgeInsets.only(bottom: Dimensions.getScaleHeight(32.0)),
              child: SvgPicture.asset('assets/icons/Success.svg'),
            ),
            const CustomText(
              text: 'ĐẶT HÀNG THÀNH CÔNG',
              color: AppColors.mainAppColor,
              size: 24,
              fontWeight: FontWeight.w700,
            ),
            Container(
              margin: EdgeInsets.only(top: Dimensions.getScaleHeight(0.8)),
              child: CustomText(
                text: 'Hệ thống đã tiếp nhận đơn hàng của bạn',
                color: AppColors.primaryColor.withOpacity(0.8),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}