import 'package:ecommerce_app_flutter/models/san_pham.dart';
import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/cart.dart';
import '../../provider/sanPhamProvider.dart';
import '../../utils/app_colors.dart';
import '../../utils/common.dart';
import '../../utils/dimension.dart';
import '../../widgets/devider_widget.dart';
import '../../widgets/small_text.dart';

class CartTile extends StatelessWidget {
  final Cart data;
  final String domain;
  final Function(bool isIncrement) addToCart;
  final Function(int productId) removeFromCart;
  final Function(int producId) checkProduct;

  const CartTile(
      {
        required this.data,
        required this.domain,
        required this.addToCart,
        required this.removeFromCart,
        required this.checkProduct,
        super.key
      });

  @override
  Widget build(BuildContext context) {
    late SanPham product;
    double borderRadius = 10.0;
    Future.delayed(Duration.zero, () async {
      var apiProducts = await ProductProvider.getDetailProduct(data.productId);
      product = apiProducts;
    });

    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(onPressed: (context) => {
            removeFromCart(data.productId)
          },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Xóa',
          )
        ],

      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: Dimensions.getScaleHeight(120.0),
        padding: EdgeInsets.only(
            left: Dimensions.getScaleHeight(5),
            right: Dimensions.getScaleHeight(5)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(Dimensions.getScaleHeight(borderRadius)),
          border: Border.all(
              color: AppColors.silver, width: Dimensions.getScaleHeight(1.0)),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.getScaleHeight(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: Dimensions.getScaleWidth(20),
                    left: Dimensions.getScaleWidth(5),
                    right: Dimensions.getScaleWidth(10)),
                child: SizedBox(
                  width: Dimensions.getScaleWidth(20.0),
                  height: Dimensions.getScaleWidth(20.0),
                  child: Checkbox(
                    value: data.isCheck,
                    onChanged: (bool? value) {
                      checkProduct(data.productId);
                    },
                    activeColor: AppColors.primaryColor,
                    side: const BorderSide(width: 1.0, color: AppColors.primaryColor),
                  ),
                ),
              ),
              // Image
              Container(
                  width: Dimensions.getScaleHeight(70),
                  height: Dimensions.getScaleHeight(70),
                  decoration: BoxDecoration(
                    color: AppColors.silver,
                    borderRadius: BorderRadius.circular(borderRadius),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('$domain${data.image}'),
                    ),
                  )),
              // Info
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.getScaleWidth(10.0),
                        right: Dimensions.getScaleWidth(10.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: data.name,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainAppColor,
                        ),
                        CustomText(
                          text: StringUtils.convertVnCurrency(data.price),
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: Dimensions.getScaleHeight(5.0)),
                child: Column(
                  children: [
                    // Increment Decrement Button
                    Container(
                      height: Dimensions.getScaleHeight(40),
                      width: Dimensions.getScaleHeight(120.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              addToCart(false);
                            },
                            child: Container(
                              width: Dimensions.getScaleWidth(26.0),
                              height: Dimensions.getScaleWidth(40.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.getScaleWidth(8)),
                                color: AppColors.primaryColor,
                              ),
                              child: const CustomText(
                                text: '-',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.getScaleWidth(8.0)),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomText(
                                text: '${data.count}',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              addToCart(true);
                            },
                            child: Container(
                              width: Dimensions.getScaleWidth(26.0),

                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.getScaleWidth(8.0)),
                                color: AppColors.primaryColor,
                              ),
                              child: const CustomText(
                                text: '+',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DividerWidget(size: Dimensions.getScaleHeight(10.0)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
