import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/image_slider.dart';
import '../components/main_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/wallpaper.jpg'))),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            SizedBox(
              height: size.height / 2,
              child: PageView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const SingleChildScrollView(child: ImageSlider());
                },
                itemCount: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  activeDotColor: AppColors.mainAppColorLight,
                  dotColor: AppColors.mainAppColor.withOpacity(0.3),

                  dotHeight: 12,
                  dotWidth: 12,
                  type: WormType.normal,
                  // strokeWidth: 5,
                ),
              ),
            ),
            const Spacer(),
            const MainButton(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
