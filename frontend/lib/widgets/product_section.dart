import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/next_page.dart'; // Make sure to import NextPage class

class ProductSection extends StatelessWidget {
  final String title;
  final List<dynamic> products;
  final Color customGreen;

  ProductSection({
    required this.title,
    required this.products,
    required this.customGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Expanded(
          child: products.length == 0 ?
            Text("You don't have any products yet.")
          : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              var productName = product['name'];
              var productCategory = product['category']['name'];
              var quantity = product['quantity'];
              var price = product['price'];
              var status = price.toString() + ' Ft/kg'; // TODO
              var imgSrc = 'assets/images/product.jpg'; // TODO

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                },
                child: Card(
                  color: customGreen, // Green background for the card
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
                          color: customGreen,
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
                                            MaterialPageRoute(builder: (context) => NextPage()),
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
            },
          ),
        ),
      ],
    );
  }
}
