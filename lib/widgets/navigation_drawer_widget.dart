import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimension.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(
            top: Dimensions.getScaleHeight(20),
          left: Dimensions.getScaleWidth(10),
          right: Dimensions.getScaleWidth(45),
        ),
        color: AppColors.mainAppColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only( left: Dimensions.getScaleWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1640915550677-26ade06905fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzN3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
                  ),
                  SizedBox(
                    height: Dimensions.getScaleHeight(10),
                  ),
                  const CustomText(
                      text: "Nguyễn Hoàng Diệu",
                    color: Colors.white,

                  )
                ],
              ),
            ),
            SizedBox(height: Dimensions.getScaleHeight(20)),
            const Divider(thickness: 1,color: Colors.white,),
            buildMenuItem(
              text: 'Cá nhân',
              icon: Icons.person_outline_outlined,
              onClick: (){

              }
            ),
            buildMenuItem(
                text: 'Sản phẩm',
                icon: Icons.coffee,
                onClick: (){

                }
            ),
            buildMenuItem(
                text: 'Giỏ hàng',
                icon: Icons.shopping_cart,
                onClick: (){

                }
            ),
            const Divider(thickness: 1,color: Colors.white,),
            buildMenuItem(
                text: 'Đăng nhập',
                icon: Icons.login,
                onClick: (){

                }
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClick
}){
    const color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color,),
      title: CustomText(
        text: text,
        color: color,
      ),
      hoverColor: hoverColor,
      onTap: onClick,
    );
  }
}
