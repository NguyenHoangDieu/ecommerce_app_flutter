import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'category_card.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        children: [
          CategoryItem(
            title: 'Cà phê',
            isSelected: true,
          ),
        ],
      ),
    );
  }
}
