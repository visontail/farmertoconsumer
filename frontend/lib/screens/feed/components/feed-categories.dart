import 'package:farmertoconsumer/models/productCategory.dart';
import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

typedef SelectCategoryCallback = void Function(int);

class FeedCategories extends StatefulWidget {
  _FeedCategoriesState createState() => _FeedCategoriesState();
}

class _FeedCategoriesState extends State<FeedCategories> {
  String capitalizeFirstChar(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: provider.categories.map((ProductCategory category) {
          return GestureDetector(
            onTap: () {
              if (provider.selectedCategoryId == category.id) {
                provider.selectCategory(null);
              } else {
                provider.selectCategory(category.id);
              }
            },
            child: Container(
              margin: const EdgeInsets.all(7),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: category.id == provider.selectedCategoryId
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
        }).toList()));
  }
}
