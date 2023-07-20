import 'package:ecommerce_app_flutter/screens/home_page.dart';
import 'package:ecommerce_app_flutter/screens/product_list_page.dart';
import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../models/user.dart';
import '../../state_maneger/cart_changeNotifier.dart';
import '../../state_maneger/user_changeNotifier.dart';
import '../../utils/app_colors.dart';
import '../../utils/common.dart';
import '../../utils/dimension.dart';
import '../../utils/helper.dart';
import '../../widgets/devider_widget.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/share_widget.dart';
import '../../widgets/small_text.dart';
import 'cart_confirm_page.dart';
import 'cart_sqflte.dart';
import 'cart_tile.dart';

class CartPage extends StatefulWidget {
  static const routeName = "/cart_page_screen";
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool? _checkAllProduct = false;
  var user = User();
  var api = '';
  var totalIsChecked = 1.0;
  bool? isChecked = true;
  List<Cart> idListItemChecked = [];
  var total = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      api = await Services.getApiLink();
      user = currUser;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CartChangeNotifier>(
        builder: (context, cartNotif, child){
          return  Scaffold(
            appBar: SharedWidget.getAppBar('Giỏ hàng', context),
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
                    backgroundColor: AppColors.mainAppColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(Dimensions.getScaleHeight(16))),
                    elevation: 0,
                  ),
                  onPressed: cartNotif.items.isNotEmpty
                      ? () {

                    for (var item in cartNotif.items) {
                      if (item.isCheck) {
                        idListItemChecked.add(item);
                      }
                      else{
                        idListItemChecked.remove(item);
                      }
                    }
                    Map<String, Object> myData = {
                      'idListItemChecked': idListItemChecked,
                      'deliveryMethod': 1,
                    };
                    if(idListItemChecked.isNotEmpty){
                      Navigator.pushNamed(context, CartConfirmPage.routeName, arguments: myData);
                    }
                    else{
                      SharedWidget.showNotifToast('Vui lòng chọn sản phẩm', isSucceed: false);
                    }
                    // idListItemChecked = (cartNotif.items.map<int>((item) => item.productId)).toList();

                  }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CustomText(
                          text: 'Mua hàng',
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
                      if (cartNotif.items.isNotEmpty)
                        Flexible(
                          flex: 6,
                          child: CustomText(
                            text: StringUtils.convertVnCurrency(cartNotif.items.isEmpty ? 0.0 :
                            cartNotif.items.where((element) => element.isCheck == true).
                            map<double>((item) => item.count * item.price).isEmpty? 0.0:
                            cartNotif.items.where((element) => element.isCheck == true).
                            map<double>((item) => item.count * item.price).reduce((value1, value2) => value1 + value2)),
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            size: Dimensions.getScaleHeight(14),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              body: Stack(
                  children: [
                    SizedBox(
                      height: Dimensions.getScaleHeight(80),
                    ),
                cartNotif.items.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const EmptyListWidget(
                        messagePrefix: 'Không có sản phẩm nào trong',
                        message: 'Giỏ hàng',
                        icon: Icons.shopping_cart_sharp),
                    const DividerWidget(size: 15),
                    SizedBox(
                      width: Dimensions.getScaleWidth(200.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.mainAppColor,
                            backgroundColor: AppColors.mainAppColor
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, ProductListScreen.routeName);
                          },
                          child: const CustomText(
                              text: 'MUA SẮM', color: Colors.white)),
                    )
                  ],
                )
                    : ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(Dimensions.getScaleHeight(16.0)),
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: Dimensions.getScaleHeight(5.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: Dimensions.getScaleWidth(10.0)),
                                  width: Dimensions.getScaleWidth(20.0),
                                  height: Dimensions.getScaleWidth(20.0),
                                  child: Checkbox(
                                    value: _checkAllProduct,
                                    activeColor: AppColors.primaryColor,
                                    side: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: Dimensions.getScaleWidth(1.0)),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checkAllProduct = value;
                                        cartNotif.checkAll(value!);
                                      });
                                    },
                                  )),
                              DividerWidget(
                                size: Dimensions.getScaleWidth(10.0),
                                isVertical: false,
                              ),
                              CustomText(
                                  text:
                                  '${StringUtils.padLeftZero(cartNotif.countProduct)} sản phẩm')
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      itemCount: cartNotif.items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var cartData = cartNotif.items[index];

                        return CartTile(
                            data: cartData,
                            domain: api,
                            addToCart: (bool isIncrement) {
                              var cartItem = cartData;
                              var isSucceed = true;
                              CartSqlite.updateQuantity(cartItem.productId, user.id??0, isIncrement: isIncrement).then((result) {
                                if (result > 0) {
                                  cartNotif.addMoreToCart(cartItem.productId,
                                      isIncrement: isIncrement);
                                } else {
                                  isSucceed = false;
                                }
                              });

                              if (!isSucceed) {
                                SharedWidget.showNotifToast(
                                    'Có lỗi xảy ra! Vui lòng thử lại',
                                    isSucceed: false);
                              }
                            },
                            removeFromCart: (int productId) {
                              return showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                        title: const CustomText(
                                          text: 'XÓA SẢN PHẨM KHỎI GIỎ HÀNG',
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const CustomText(
                                                text: 'Đồng ý'),
                                            onPressed: () {
                                              CartSqlite.removeFromCart(productId, user.id??0).then((rows) {
                                                if (rows > 0) {
                                                  cartNotif.removeFromCart(
                                                      productId);
                                                  Navigator.of(context).pop();
                                                  SharedWidget.showNotifToast(
                                                      'Xóa sản phẩm thành công');
                                                } else {
                                                  SharedWidget.showNotifToast(
                                                      'Có lỗi xảy ra!',
                                                      isSucceed: true);
                                                }
                                              });
                                            },
                                          ),
                                          TextButton(
                                            child: const CustomText(
                                                text: 'Hủy bỏ',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]);
                                  });
                            },
                            checkProduct: (int productId) {
                              cartNotif.check(productId);
                              setState(() {
                                _checkAllProduct = cartNotif.countProduct ==
                                    cartNotif.countCheckedProduct;

                              });
                            });
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: Dimensions.getScaleHeight(16.0)),
                    ),
                  ],
                ),
              ]));
        }
    );
  }
}
