import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/custom_button.dart';
import 'counter.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_button.dart'; // Import the AnimatedButton widget

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
    final productService = Provider.of<ProductService>(context, listen: false);
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

    // Define customGreen color
    final customGreen = Color(0xFF48872B);

    bool _isLoading = false;

    return Scaffold(
      backgroundColor: customGreen, // Use customGreen for background
      appBar: CustomAppBar(title: 'Product Page', customGreen: customGreen),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(color: customGreen, width: 5.0), // Border color
            borderRadius: BorderRadius.circular(12),
            color: Colors.white, // Container background color
          ),
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
                        // Product image placeholder
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image, size: 50, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Product Name and Quantity Counter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product!.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: customGreen, // Use customGreen for text
                              ),
                            ),
                            Counter(
                              initialValue: quantity,
                              maxValue: product!.quantity,
                              onChanged: (newQuantity) {
                                setState(() {
                                  quantity = newQuantity;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Price and Unit
                        Text(
                          '${product?.price} Ft / ${product?.quantityUnit.name}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),

                        // Category Type
                        Text(
                          'Type - ${product?.category.name}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 32),

                        // Order Button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0), // Add some padding for spacing
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the button horizontally
                            children: [
                              AnimatedButton(
                                text: 'Get Started',
                                isLoading: _isLoading,
                                onPressed: () {
                                  // TODO
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Producer Info Section
                        Text(
                          'Learn about the producer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: customGreen, // Producer section text color
                          ),
                        ),
                        const SizedBox(height: 8),
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
      ),
    );
  }
}
