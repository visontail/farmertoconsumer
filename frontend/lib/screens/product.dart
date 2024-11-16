import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';
import '../widgets/custom_button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Map<String, dynamic>? productData;
  String? errorMessage;

  Future<void> fetchProduct(String id) async {
    final productService = Provider.of<ProductService>(context, listen: false);
    final response = await productService.getProduct(id);

    if (response['status'] == 'success') {
      setState(() {
        productData = response['data'];
        errorMessage = null;
      });
    } else {
      setState(() {
        productData = null;
        errorMessage = response['message'];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var quantity = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              text: 'See product',
              onPressed: () => fetchProduct("1"),
            ),
            const SizedBox(height: 16),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (productData != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Placeholder kép
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 2. Product neve
                      Text(
                        productData!['name'] ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 3. Ár és quantityUnit
                      Text(
                        '${productData!['price']} Ft / ${productData!['quantityUnit']['name']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),

                      // 4. Típus - kategória
                      Text(
                        'Type - ${productData!['category']['name']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),

                      // 5. Rendelés gomb
                      ElevatedButton(
                        onPressed: () {
                          // Ide jöhet rendelés logika
                          print('Order button clicked!');
                        },
                        child: const Text('Order'),
                      ),
                      const SizedBox(height: 16),

                      // 6. Learn about the producer
                      Text(
                        'Learn about the producer',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 7. Producer adat / description
                      Text(
                        '${productData?['producer']?['name']} - ${productData?['producer']?['producerData']?['description'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      // 8. Product Counter (Quantity management)
                      Row(
                        children: [
                          const Text(
                            'Quantity:',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$quantity', // Dynamically displaying the quantity
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++; // Increase the quantity
                              });
                              print("Increased quantity: $quantity");
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--; // Decrease the quantity
                                });
                                print("Decreased quantity: $quantity");
                              }
                            },
                          ),
                        ],
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
}

