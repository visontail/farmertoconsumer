import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/next_page.dart'; // Make sure to import NextPage class

class OrderSection extends StatelessWidget {
  final String title;
  final List<String> orders;
  final Color customGreen;

  OrderSection({required this.title, required this.orders, required this.customGreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        SizedBox(height: 20),
        // Wrap the ListView in an Expanded widget to take the remaining space
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to NextPage when the card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                },
                child: Card(
                  color: customGreen,  // Green background for the card
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // Set the border radius here
                  ),
                  elevation: 0, // Remove the default elevation to use custom shadow
                  child: Container(
                    decoration: BoxDecoration(
                      color: customGreen, // Keep the card background green
                      borderRadius: BorderRadius.circular(6), // Border radius same as card's
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x55000000), // Shadow color with opacity for a subtle effect
                          offset: Offset(0, 4), // Shadow position: x: 0, y: 4
                          blurRadius: 4, // Blur radius
                          spreadRadius: 0, // Spread radius
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          // Image and caption section (taking 60% of width)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45, // Set image to take 60% width
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12), // Apply border radius to image
                                  child: Image.asset(
                                    'assets/images/product.jpg',
                                    width: double.infinity, // Make the image fill its container
                                    height: 100, // Set height of the image
                                    fit: BoxFit.cover, // Use BoxFit to adjust the image's aspect ratio
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Carrots from Baja',
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 0),
                          // Right-side info section (taking 40% of width)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3, // Set text section to take 40% width
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Display quantity and status
                                Center(
                                  child: Text(
                                    '6',  // Display the quantity
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'quantity',  // Display the quantity label
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Center(
                                  child: Text(
                                    'In Progress',  // Display the status
                                    style: TextStyle(fontSize: 14, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Button positioned at the bottom-right corner
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigate to the next page when the button is clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => NextPage()), // Ensure NextPage is imported
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero, // No padding for the button
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6), // Set the border radius here
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'View Details',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
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
                ),

              );
            },
          ),
        ),
      ],
    );
  }
}
