import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/custom_button.dart';
import 'counter.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  const ProductScreen({super.key, required this.id});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product? product;
  String? errorMessage;

  Future<void> fetchProduct(String id) async {
    final productService = ProductService();
    product = await productService.getProduct(id);

    if (product != null) {
      setState(() {
        errorMessage = null;
      });
    } else {
      setState(() {
        errorMessage = 'Error!';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProduct(widget.id);
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
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (product != null)
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // 2. Product neve
                        children: [
                          Text(
                            product!.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // 8. Product Counter (Quantity management)
                          Counter(
                            initialValue: quantity,
                            maxValue: product!.quantity,
                            onChanged: (newQuantity) {
                              setState(() {
                                quantity = newQuantity; // Update quantity when counter changes
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // 3. Ár és quantityUnit
                      Text(
                        '${product?.price} Ft / ${product?.quantityUnit.name}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),

                      // 4. Típus - kategória
                      Text(
                        'Type - ${product?.category.name}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 32),

                      // 5. Rendelés gomb
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // 2. Product neve
                        children: [
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                // Ide jöhet rendelés logika
                                print('Order button clicked!');
                              },
                              child: const Text('Order'),
                            ),
                          )
                        ]
                      ),
                      const SizedBox(height: 32),

                      // 6. Learn about the producer
                      const Text(
                        'Learn about the producer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 7. Producer adat / description
                      Text(
                        '${product?.user.name} - ${product?.user.producerData?.description}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
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

