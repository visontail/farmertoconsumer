import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login.dart';
import '../screens/registration.dart';
import 'screens/feed/feed.dart';
import 'screens/product-modify.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductModifyForm(),
      ),
    );
  }
}
