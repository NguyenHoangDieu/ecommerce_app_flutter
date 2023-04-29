import 'package:get/get.dart';

class Dimensions {
  static const double _templateHeight = 843.4285714285714;
  static const double _templateWidth = 411.42857142857144;

  static final double screenHeight = Get.context?.height??_templateHeight;
  static final double screenWidth = Get.context?.width??_templateWidth;

  static double getScaleHeight(double? height) {
    return screenHeight / (_templateHeight / height!);
  }

  static double getScaleWidth(double? width) {
    return screenWidth / (_templateWidth / width!);
  }


}