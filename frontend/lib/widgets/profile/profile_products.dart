import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../screens/product-create.dart';
import '../../screens/product-modify.dart';
import '../product_card.dart';
import 'package:farmertoconsumer/screens/product.dart';
import 'package:farmertoconsumer/services/product_service.dart';
import '../../styles/colors.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final List<dynamic> products;
  final Color color;

  ProductSection({
    required this.title,
    required this.products,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              // Action when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductCreateForm()),
              );
            },
            icon: SvgPicture.asset(
              'assets/icons/plus-icon.svg', // Your SVG icon asset
              color: white, // Icon color
              height: 20, // Adjust the icon size
            ),
            label: Text(
              'Add Product',
              style: TextStyle(
                color: white, // Text color
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: mainGreen, // Button color
              foregroundColor: white, // Text and icon color
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(height: 6),
        Expanded(
          child: products.isEmpty
              ? Padding( padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0), child: Text("You don't have any products yet."))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return ProductCard(
                      product: product,
                      color: color,
                    );
                  },
                ),
          ),
      ],
    );
  }
}