import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class DividerWidget extends StatelessWidget {
  final double size;
  final bool isVertical;
  const DividerWidget({this.size = 10, this.isVertical = true, super.key});

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? SizedBox(height: Dimensions.getScaleHeight(size))
        : SizedBox(width: Dimensions.getScaleHeight(size));
  }
}