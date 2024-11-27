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
  final _formKey = GlobalKey<FormState>(); 

  String name = "golden carrot";
  String category = "carrot";
  String metric = "kg";
  int price = 0;
  int quantity = 1;
  String description = "asdasdasdasdsadasdasd";

  // Initialising initial values with TextEditingControllers
  late final TextEditingController nameController;
  late final TextEditingController categoryController;
  late final TextEditingController metricController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    // Setting default values in TextEditingControllers
    nameController = TextEditingController(text: name);
    categoryController = TextEditingController(text: category);
    metricController = TextEditingController(text: metric);
    priceController = TextEditingController(text: price.toString());
    descriptionController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    //Release: no memory leaks
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
            Navigator.pop(context); // navigate back to the previous screen
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

              //Product name
              Text(
                'Product Name',
                style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'product Name',
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
              ),
              const SizedBox(height: 16),

              //Category
              Text(
                'Category',
                style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  hintText: 'category',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainGreen, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Metric
              Text(
                'Metric',
                style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: metricController,
                decoration: const InputDecoration(
                  hintText: 'metric',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainGreen, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the metric';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Price
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
              ),
              const SizedBox(height: 16),

              //Quantity            
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
              Text(
                'Description',
                style: TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'description',
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

                        Navigator.pop(context); // navigate back to the previous screen
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainGreen, foregroundColor: white),
                    child: const Text('Save Product'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: delete product

                      Navigator.pop(context); // navigate back to the previous screen
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
