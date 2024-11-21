import 'package:flutter/material.dart';

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
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: customGreen),
        ),
        SizedBox(height: 10),
        
        // Wrap the ListView in an Expanded widget to take the remaining space
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Card(
                color: customGreen,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Image and caption section
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/product.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Order ${index + 1}',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      
                      // Right-side info section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Additional Info',
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'View Details',
                                style: TextStyle(color: customGreen),
                              ),
                            ),
                          ],
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
