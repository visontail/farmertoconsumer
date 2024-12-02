import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/product-create.dart';
import '../screens/product-modify.dart';
import 'package:farmertoconsumer/screens/product.dart';
import 'package:farmertoconsumer/services/product_service.dart';
import '../styles/colors.dart';

// ProductCard Widget: Extracted from ProductSection
class ProductCard extends StatelessWidget {
  final dynamic product;
  final Color color;

  ProductCard({
    required this.product,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var productId = product['id'];
    var productName = product['name'];
    var productCategory = product['category']['name'];
    var quantity = product['quantity'];
    var price = product['price'];
    var status = price.toString() + ' Ft/kg'; // TODO
    var imgSrc = 'assets/images/product.jpg'; // Placeholder image source

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen(id: productId.toString())),
        );
      },
      child: Card(
        color: color, // Green background for the card
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
        child: Stack(
          children: [
            // Card content
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x55000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    // Image and caption section
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              imgSrc,
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            productName,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 0),
                    // Right-side info section
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: Text(
                              '$quantity',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              productCategory,
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 6),
                          Center(
                            child: Text(
                              status,
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 0),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductScreen(id: productId.toString())),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'View Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/right-arrow-2.svg',
                                    width: 10.0,
                                    height: 10.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SVG Icon on the top-right corner
            Positioned(
              top: 8,
              right: 8,
              child: SvgPicture.asset(
                'assets/icons/edit-icon.svg', // Your icon path
                width: 24.0,  // Adjust size as needed
                height: 24.0, // Adjust size as needed
                color: Colors.white, // Icon color
              ),
            ),
          ],
        ),
      ),
    );
  }
}