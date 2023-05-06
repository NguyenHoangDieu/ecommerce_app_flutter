
import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:ecommerce_app_flutter/utils/dimension.dart';
import 'package:flutter/material.dart';

import '../components/details_screen_sections.dart';

class ProducDetailsScreen extends StatelessWidget {
  const ProducDetailsScreen({Key? key}) : super(key: key);


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
                        children: const [
                          Text('Cà phê',
                              style: TextStyle(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          SizedBox(
                            height: 40,
                            child: VerticalDivider(
                              color: Colors.black45,
                            ),
                          ),
                          Text('Chocolate',
                              style: TextStyle(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          SizedBox(
                            height: 40,
                            child: VerticalDivider(
                              color: Colors.black45,
                            ),
                          ),
                          Text('Sữa tươi',
                              style: TextStyle(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0, top: 20, bottom: 10),
                      child: Text("Coffee size",
                          style: TextStyle(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 22)),
                    ),
                    const SizeListSection(),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        top: 10,
                      ),
                      child: Text("Chi tiết",
                          style: TextStyle(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 22)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 30.0, top: 10, bottom: 10, right: 30),
                      child: Text(
                          "Cà phê được chọn lọc nguyên chất kết hợp với chocolate và sữa tươi "
                              "Ba Vì tạo nên 1 tuyệt phẩm thấm đẫm vị ngọt, béo và pha chút hương vị cà phê cho bạn một ngày dài năng động...",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16)),
                    ),
                    const AddToCartCard(),
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
