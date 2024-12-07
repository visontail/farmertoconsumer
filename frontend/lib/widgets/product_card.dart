import 'package:farmertoconsumer/screens/product-modify.dart';
import 'package:farmertoconsumer/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  final Color color;

  ProductCard({
    required this.product,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    int? productId = product?.id ?? -1;
    String productName = product?.name ?? '';
    String productCategory = product?.category?.name ?? '';
    String productquantityUnit = product?.quantityUnit?.name ?? '';
    String productQuantity = product?.quantity?.toString() ?? '';
    productQuantity +=  " " + productquantityUnit;
    String productPrice = product?.price.toString() ?? '';
    productPrice += ' Ft/' + productquantityUnit;

    return GestureDetector(
      onTap: () {
        // Handle card tap (e.g., navigate to product details)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductModifyForm(id: productId)),
        );
      },
      child: Card(
        color: color,
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
                              'assets/images/product.jpg', // Example image
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
                              productQuantity, // Example quantity
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              productCategory, // Example category
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 6),
                          Center(
                            child: Text(
                              productPrice, // Example price
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SVG Deny Icon on the top-right corner
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  // Show confirmation dialog when deny icon is clicked
                  _showConfirmationDialog(context);
                },
                child: SvgPicture.asset(
                  'assets/icons/deny.svg', // Your deny icon path
                  width: 16.0,  // 16x16 size for the icon
                  height: 16.0, // 16x16 size for the icon
                  color: Colors.white, // Icon color (white)
                ),
              ),
            ),
            // Edit Button and SVG Icon positioned closer to the bottom-right
            Positioned(
              bottom: -4,  // Changed from 8 to 4 for a lower position
              right: 0,
              child: TextButton(
                onPressed: () {
                  // Handle Edit button click
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductModifyForm(id: productId)),
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
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/edit.svg', // Example edit icon
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
    );
  }

  // Method to show a confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete this product?'),
          content: Text('This cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Handle the action to deny the request (e.g., delete or reject)
                print('Action Denied');
              },
              child: Text('Yes, Delete'),
            ),
          ],
        );
      },
    );
  }
}
