import 'package:ecommerce_app_flutter/utils/app_colors.dart';
import 'package:flutter/widgets.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset(
          'assets/coffee.png',
          width: size.width / 1.5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8.0),
          child: Text(
            'D-Coffee thơm ngon,\n đậm vị tình yêu!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColors.mainAppColor
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 8,
          ),
          child: Text(
            'The best grain, the finest roast, the most powerful flavor',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
