import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_app_bar.dart';
import '../widgets/upgrade_section.dart';
import '../widgets/order_section.dart';
import '../widgets/product_section.dart';
import '../styles/colors.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  ProductFormScreenState createState() => ProductFormScreenState();
}

class ProductFormScreenState extends State<ProductFormScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String productType = '';
  String productCategory = '';
  String productMetric = '';
  int productQuantity = 0;
  String productDescription = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height for using it to set the minimum height
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: mainGreen,
      appBar: CustomAppBar(title: 'Add Product', color: mainGreen),
      body: SingleChildScrollView(  // Wrapping body in SingleChildScrollView
        child: Container(
          height: screenHeight, // Set the height to be at least 100% of the screen height
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          decoration: BoxDecoration(
            border: Border.all(color: mainGreen, width: 5.0),
            borderRadius: BorderRadius.circular(12),
            color: white,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product Name
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: TextStyle(color: mainGreen),
                    hintText: 'Enter product name',
                    hintStyle: TextStyle(color: mainGreen.withOpacity(0.6)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      productName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                // Product Type
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Type',
                    labelStyle: TextStyle(color: mainGreen),
                    hintText: 'Enter product type',
                    hintStyle: TextStyle(color: mainGreen.withOpacity(0.6)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      productType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                // Product Category
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Category',
                    labelStyle: TextStyle(color: mainGreen),
                    hintText: 'Enter product category',
                    hintStyle: TextStyle(color: mainGreen.withOpacity(0.6)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      productCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                // Product Metric
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Metric',
                    labelStyle: TextStyle(color: mainGreen),
                    hintText: 'Enter product metric',
                    hintStyle: TextStyle(color: mainGreen.withOpacity(0.6)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      productMetric = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product metric';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                // Product Quantity
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Quantity',
                    labelStyle: TextStyle(color: mainGreen),
                    hintText: 'Enter product quantity',
                    hintStyle: TextStyle(color: mainGreen.withOpacity(0.6)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      productQuantity = int.tryParse(value) ?? 0;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                // Product Description (Text Area)
                TextFormField(
                  maxLines: 5, // Textarea effect
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                    labelStyle: TextStyle(color: mainGreen),
                    hintText: 'Enter product description',
                    hintStyle: TextStyle(color: mainGreen.withOpacity(0.6)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      productDescription = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                // Submit Button
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            // Add your submit logic here (e.g., API call)
                            // After submission, set `isLoading` to false
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGreen,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/plus-icon-2.svg', // Path to your white SVG icon
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Add Product',
                              style: TextStyle(color: white, fontSize: 16),
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
  }
}
