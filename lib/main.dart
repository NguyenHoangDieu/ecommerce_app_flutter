import 'package:ecommerce_app_flutter/screens/cart/cart_confirm_page.dart';
import 'package:ecommerce_app_flutter/screens/cart/cart_page.dart';
import 'package:ecommerce_app_flutter/screens/cart/cart_success_page.dart';
import 'package:ecommerce_app_flutter/screens/detail_product.dart';
import 'package:ecommerce_app_flutter/screens/home_page.dart';
import 'package:ecommerce_app_flutter/screens/intro_page.dart';
import 'package:ecommerce_app_flutter/screens/login_page.dart';
import 'package:ecommerce_app_flutter/screens/profile_screen.dart';
import 'package:ecommerce_app_flutter/screens/register_page.dart';
import 'package:ecommerce_app_flutter/state_maneger/cart_changeNotifier.dart';
import 'package:ecommerce_app_flutter/state_maneger/user_changeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserChangeNotifier()),
        ChangeNotifierProvider(create: (_) => CartChangeNotifier())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const IntroScreen(),
          '/home_page': (context) => const HomePageScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/product_detail': (context) => const DetailProductScreen(),
          '/cart_page_screen': (context) => const CartPage(),
          '/cart_confirm_screen': (context) => const CartConfirmPage(),
          '/cart_success_screen': (context) => const CartSuccessPage()
        },
      ),
    );
  }
}

