import 'package:farmertoconsumer/models/productCategory.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final ProductCategory category;
  final Function(int?) selectCategory;
  final int? selectedCategoryId;

  const CategoryCard({
    super.key,
    required this.category,
    required this.selectCategory,
    required this.selectedCategoryId,
  });

  capitalizeFirstChar(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedCategoryId == category.id) {
          selectCategory(null);
        } else {
          selectCategory(category.id);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: category.id == selectedCategoryId
                ? lightGreen
                : mainGreen,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ]),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO - fallback svg
            SvgPicture.asset(
              'assets/icons/${category.name}.svg',
              width: 30,
              color: Colors.white,
            ),
            Text(capitalizeFirstChar(category.name),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.clip,
                softWrap: false),
          ],
        )),
      ),
    );
  }
}
