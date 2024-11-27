import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/models/productCategory.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/colors.dart';

class ProductModifyForm extends StatefulWidget {
  @override
  _ProductCreateFormState createState() => _ProductCreateFormState();
}

class _ProductCreateFormState extends State<ProductModifyForm> {
  final _formKey = GlobalKey<FormState>(); // Űrlap állapot kulcsa

  String name = "golden carrot";
  String category = "carrot";
  String metric = "kg";
  int price = 0;
  int quantity = 1;
  String description = "asdasdasdasdsadasdasd";

  // Kezdő értékek inicializálása a TextEditingController-ekkel
  late final TextEditingController nameController;
  late final TextEditingController categoryController;
  late final TextEditingController metricController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    // Alapértelmezett értékek beállítása a TextEditingController-ekben
    nameController = TextEditingController(text: name);
    categoryController = TextEditingController(text: category);
    metricController = TextEditingController(text: metric);
    priceController = TextEditingController(text: price.toString());
    descriptionController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    // Felszabadítás: ne legyen memória szivárgás
    nameController.dispose();
    categoryController.dispose();
    metricController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/icons/icon.svg',
              width: 30,
              height: 30,
              color: white,
            ),
          ],
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            width: 30,
            height: 30,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context); // Visszatérés az előző képernyőre
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
              //Product name
              Text('Product Name'),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Category
              Text('Category'),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  hintText: 'category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Metric
              Text('Metric'),
              TextFormField(
                controller: metricController,
                decoration: const InputDecoration(
                  hintText: 'metric',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a metric';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Price
              Text('Price'),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: 'price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Quantity            
              Row(
                children: [
                  const Text("Quantity"),
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
                  Text(quantity.toString()), 
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

              //Description
              Text('Description'),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Save és Delete gombok (változatlanok maradnak)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Product name: ${nameController.text}');
                        print('Product category: ${categoryController.text}');
                        print('Product metric: ${metricController.text}');
                        print('Price: ${priceController.text}');
                        print('Product quantity: ${quantity}');
                        print('Product description: ${descriptionController.text}');
                        
                        name = nameController.text;
                        category = categoryController.text;
                        metric = metricController.text;
                        description = descriptionController.text;

                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainGreen, foregroundColor: white),
                    child: const Text('Save Product'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // delete product logic
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, foregroundColor: white),
                    child: const Text('Delete Product'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
