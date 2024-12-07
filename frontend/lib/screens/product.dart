import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:farmertoconsumer/services/oder_service.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/counter.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  const ProductScreen({super.key, required this.id});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product? product;
  String? errorMessage;
  late OrderService orderService;
  int quantity = 1;
  AuthProvider authProvider = AuthProvider();

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
    orderService = OrderService();
  }

  @override
  Widget build(BuildContext context) {
    var quantity = 1;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset('assets/icons/icon.svg', width: 30, height: 30, color: white)
          ],
        ),
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back-arrow.svg', width: 30, height: 30, color: white,),
          onPressed: () {
            Navigator.pop(context); // navigate back
          },
        ),
        backgroundColor: mainGreen,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: mainGreen,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 80
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // 1. Picture
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        // Green box
                        Container(
                          height: 100,
                          color: mainGreen,
                        ),
                        // White box
                        Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24.0, 100.0, 24.0, 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (errorMessage != null)
                                  Text(
                                    errorMessage!,
                                    style: const TextStyle(color: Colors.red, fontSize: 16),
                                  ),
                                if (product != null)
                                  ...[
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // 2. Product Name
                                      children: [
                                        Text(
                                          product!.name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: mainGreen,
                                          ),
                                        ),

                                        // 3. Product Counter (Quantity management)
                                        Counter(
                                          initialValue: quantity,
                                          maxValue: product!.quantity,
                                          onChanged: (newQuantity) {
                                            setState(() {
                                              quantity = newQuantity; // Update state
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    // 4. Price and QuantityUnit
                                    Text(
                                      '${product?.price} Ft / ${product?.quantityUnit.name}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: paleGreen
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // 5. Type - Category
                                    Text(
                                      'Type - ${product?.category.name}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: mainGreen,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // 6. Product Description
                                    Text(
                                      product!.description,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: paleGreen,
                                      ),
                                    ),
                                    const SizedBox(height: 32),

                                    // 7. Order Button
                                    authProvider.isAuthenticated ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 225,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: mainGreen,
                                              foregroundColor: white,
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(6), // Border-radius
                                              ),
                                            ),
                                            onPressed: () async {
                                              Order? order = await orderService.postOrder(product!, quantity);
                                              if(order != null) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Successful Order"),
                                                      content: Text('${order.quantity} ${order.quantityUnit.name} of ${order.product.name}: ${order.fullPrice} Ft'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("OK"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: const Text('Order'),
                                          ),
                                        )
                                      ]
                                    ) : const SizedBox.shrink(),
                                    authProvider.isAuthenticated ? const SizedBox(height: 32) : const SizedBox.shrink(),

                                    // 8. Learn about the producer
                                    const Text(
                                      'Learn about the producer',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: mainGreen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // 9. Producer Name
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        '${product?.user.name}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: mainGreen
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // 10. Contact Information
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Contact Information',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: mainGreen
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // 11. Producer Contact
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Text(
                                        product!.user.producerData!.contact,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: mainGreen
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // 12. Producer Description
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        product!.user.producerData!.description,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: paleGreen,

                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ]
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 353,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          'assets/images/prod-placeholder.jpg',
                          fit: BoxFit.fill,
                        )
                      ),
                    )
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

