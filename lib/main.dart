import 'package:ecommerce_app_flutter/screens/home_page.dart';
import 'package:ecommerce_app_flutter/screens/intro_page.dart';
import 'package:ecommerce_app_flutter/screens/login_page.dart';
import 'package:ecommerce_app_flutter/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroScreen(),
        '/home_page': (context) => const HomePageScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}

