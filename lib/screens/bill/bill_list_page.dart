import 'dart:io';

import 'package:ecommerce_app_flutter/provider/donHangProvider.dart';
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/utils/common.dart';
import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/don_hang.dart';
import '../../models/user.dart';
import '../../provider/userProvider.dart';
import '../../utils/api.dart';
import '../../utils/dimension.dart';
import '../../utils/helper.dart';
import '../../widgets/share_widget.dart';

class ListOrderScreen extends StatefulWidget {
  static const routeName = "/bill_list_page";
  const ListOrderScreen({Key? key}) : super(key: key);

  @override
  State<ListOrderScreen> createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  User currentUser = User();
  String api = '';
  List<DonHang> _listOrder = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      currentUser = await UserProvider.profileUser(currUser.id??0, currUser.token??'');
      api = await Services.getApiLink();
      await getOrderList();
      });
  }
  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }
  Future<void> getOrderList() async {
    try {
      var apiProductPage = await DonHangProvider.fetchListDonHang(currentUser.id??0);
      var listOrder = apiProductPage;
      setState(() {
        _listOrder = listOrder;
      });
    } on SocketException catch (ex) {
      throw Exception('Failed to load ${ex.message}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.silver,
        appBar: SharedWidget.getAppBar('Đơn hàng', context),
      body: ListView(
        children: [
          SizedBox(
            height: Dimensions.getScaleHeight(15),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimensions.getScaleWidth(20),
              right: Dimensions.getScaleWidth(20),
              bottom: Dimensions.getScaleHeight(10)
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _listOrder.length,
              itemBuilder: (context, index){
                var itemOrder = _listOrder[index];
                return Card(
                  shadowColor: AppColors.mainAppColor,
                  color: AppColors.greyLight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Mã đơn hàng: COFFEEHD8217BILL${itemOrder.id}',
                          color: AppColors.mainAppColor,
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(text: 'Người mua hàng: ${currentUser.hoVaTen}',
                          color: AppColors.primaryColor,),
                        CustomText(text: 'Đơn giá: ${StringUtils.convertVnCurrency(itemOrder.giaDonHang??0.0)}',
                          color: AppColors.primaryColor,),
                        CustomText(text: 'Ngày mua: ${itemOrder.ngayMua.toString().toFormattedVNDateTime()}',
                          color: AppColors.primaryColor,),
                        CustomText(text: 'Phương thức nhận hàng: ${itemOrder.typeNhanHang}',
                          color: AppColors.primaryColor,),
                        CustomText(text: 'Địa điểm nhận hàng: ${itemOrder.diaDiemNhanHang}',
                          color: AppColors.primaryColor,),
                      ],
                    ),
                  )
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
