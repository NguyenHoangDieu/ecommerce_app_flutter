import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class CustomText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int maxLines;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double opacity;
  final TextDecoration decoration;
  const CustomText(
      {Key? key,
        required this.text,
        this.color = Colors.black,
        this.size = 14,
        this.maxLines = 2,
        this.textAlign = TextAlign.left,
        this.opacity = 1.0,
        this.fontWeight = FontWeight.normal,
        this.decoration = TextDecoration.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines > 0 ? maxLines : null,
        textAlign: textAlign,
        overflow: maxLines > 0 ? TextOverflow.ellipsis : null,
        softWrap: true,
        style: TextStyle(
            color: color,
            decoration: decoration,
            fontSize: Dimensions.getScaleHeight(size),
            fontWeight: fontWeight));
  }
}
