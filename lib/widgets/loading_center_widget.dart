import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'devider_widget.dart';

class LoadingCenterWidget extends StatelessWidget {
  final double width;
  final Color color;
  final String title;
  const LoadingCenterWidget(
      {this.width = 0,
        this.color = AppColors.mainAppColor,
        this.title = "",
        super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: title.isEmpty
            ? CircularProgressIndicator(
          color: color,
          strokeWidth: width > 0 ? width : 4.0,
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: color,
              strokeWidth: width > 0 ? width : 4.0,
            ),
            const DividerWidget(),
            CustomText(
                text: title, size: 20, color: AppColors.mainAppColor)
          ],
        ));
  }
}
