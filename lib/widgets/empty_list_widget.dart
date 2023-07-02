import 'package:ecommerce_app_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'devider_widget.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  final String messagePrefix;
  final IconData icon;
  const EmptyListWidget(
      {required this.message,
        this.messagePrefix = "không có bản ghi",
        this.icon = Icons.find_in_page,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: AppColors.silver),
            const DividerWidget(size: 20),
            CustomText(
                text: messagePrefix.toUpperCase(),
                color: AppColors.silver,
                textAlign: TextAlign.center),
            const DividerWidget(size: 5),
            Text(message.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
          ],
        ));
  }
}
