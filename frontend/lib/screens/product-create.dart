import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:farmertoconsumer/utils/routes.dart';
import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/models/productCategory.dart';
import 'package:farmertoconsumer/models/quantityUnit.dart';
import 'package:farmertoconsumer/services/category_service.dart';
import 'package:farmertoconsumer/services/product_service.dart';
import 'package:farmertoconsumer/services/quantityUnit_service.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';

class ProductCreateForm extends StatefulWidget {
  @override
  _ProductCreateFormState createState() => _ProductCreateFormState();
}

class _ProductCreateFormState extends State<ProductCreateForm> {
  final _formKey = GlobalKey<FormState>();

  ProductCategory? selectedCategory;
  List<ProductCategory> categories = [];
  QuantityUnit? selectedQuantityUnit;
  List<QuantityUnit> quantityUnits = [];
  bool isLoading = true;
  int quantity = 1;
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      isLoading = true;
    });

    try {
      final categoryService = CategoryService();
      final response = await categoryService.getAll();

      setState(() {
        categories = response.data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load categories: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchQuantityUnits() async {
    setState(() {
      isLoading = true;
    });

    try {
      final quantityUnitService = QuantityUnitService();
      final response = await quantityUnitService.getAll();

      setState(() {
        quantityUnits = response.data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load quantity units: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    await Future.wait([
      _fetchCategories(),
      _fetchQuantityUnits()
    ]);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset('assets/icons/icon.svg', width: 30, height: 30, color: white,)
          ],
        ),
        leading: IconButton(
        icon: SvgPicture.asset('assets/icons/back-arrow.svg', width: 30, height: 30, color: white,),
        onPressed: () {
            Provider.of<FeedDataProvider>(context, listen: false).reloadProducts();
            Navigator.pushNamedAndRemoveUntil(context, Routes.feed, (_) => false);
          },
        ),
      backgroundColor: mainGreen,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
            /*
            // Drag-and-drop
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: const [
                  Icon(Icons.upload_file, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    "Drag drop some files here, or click to select files",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "* 1080 x 1080 (1:1) recommended, up to 2MB each",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),  
            */

            //name
            Text(
              'Product Name',
              style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'product name',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainGreen, width: 2.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product name';
                }
                 return null;
              },
              style: TextStyle(color: darkGreen),
            ),
            const SizedBox(height: 16),
            
            //category
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kategória szöveg
                Text(
                  'Category',
                  style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // DropdownButton a kiválasztáshoz
                DropdownButtonFormField<ProductCategory>(
                  value: selectedCategory,
                  onChanged: (ProductCategory? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Select a category',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen, width: 2.0),
                    ),
                  ),
                  items: categories.map<DropdownMenuItem<ProductCategory>>((ProductCategory category) {
                    return DropdownMenuItem<ProductCategory>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),

            //quantity unit
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantity unit',
                  style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<QuantityUnit>(
                  value: selectedQuantityUnit,
                  onChanged: (QuantityUnit? newValue) {
                    setState(() {
                      selectedQuantityUnit = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Select a quantity unit',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainGreen, width: 2.0),
                    ),
                  ),

                  items: quantityUnits.map<DropdownMenuItem<QuantityUnit>>((QuantityUnit quantityUnit){
                    return DropdownMenuItem<QuantityUnit>(
                      value: quantityUnit,
                      child: Text(quantityUnit.name),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a quantity unit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),

            //quantity            
            Row(
              children: [
                const Text(
                  "Quantity",
                  style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: mainGreen),
                  onPressed: () {
                    setState((){
                      if(quantity > 1){
                        quantity--;
                      }
                    });
                  },
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(color: darkGreen)), 
                IconButton(
                  icon: const Icon(Icons.add_circle, color: mainGreen),
                  onPressed: () {
                    setState((){
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            //price
            Text(
              'Price',
              style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                hintText: 'price',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainGreen, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                 }
                return null;
              },
              style: TextStyle(color: darkGreen)
            ),
            const SizedBox(height: 16),

            //description
            Text(
              'Description',
              style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'descrtiption',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainGreen, width: 2.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                return null;
              },
              style: TextStyle(color: darkGreen)
            ),
            const SizedBox(height: 16),

            //saving button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final productData = {
                      'name': nameController.text,
                      'categoryId': selectedCategory?.id,
                      'quantity': quantity,
                      'quantityUnitId': selectedQuantityUnit?.id,                    
                      'price': int.tryParse(priceController.text) ?? 0,
                      'description': descriptionController.text
                    };

                    final productService = ProductService();
                    final createProduct = await productService.createProduct(productData);

                    // Sikeres mentés
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added successfully!')),
                    );

                    Provider.of<FeedDataProvider>(context, listen: false).reloadProducts();
                    Navigator.pushNamedAndRemoveUntil(context, Routes.feed, (_) => false);
                  }


                  
/*
                  try {
                    final productService = Provider.of<ProductService>(context, listen: false);
                    await productService.createProduct(productData);

                    // Sikeres mentés
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added successfully!')),
                    );

                    //Navigator.pop(context); //navigate back 
                  }*/ catch (e) {
                    // Hiba kezelése
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add product: $e')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainGreen,
                foregroundColor: white),
              child: const Text('Add Product'),
            ),],
            ),
            
          ],
        ),
      ),
    ),
  );
  } 
}