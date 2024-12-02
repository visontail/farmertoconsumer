import 'package:farmertoconsumer/screens/product.dart';
import 'package:farmertoconsumer/services/product_service.dart';
import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login.dart';
import '../screens/profile.dart';
import '../screens/product_form.dart';
import '../screens/order.dart';
import 'screens/feed/feed.dart';
import '../services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthService()),
          ChangeNotifierProvider(create: (context) => FeedDataProvider()),
          ChangeNotifierProvider(create: (context) => ProductService())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductFormScreen(),
        ),
      );
  }
}
