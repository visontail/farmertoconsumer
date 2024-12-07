import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:farmertoconsumer/services/oder_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmertoconsumer/services/product_service.dart';

import 'package:farmertoconsumer/screens/feed/feed.dart';
import 'package:farmertoconsumer/screens/profile/profile.dart';
import 'package:farmertoconsumer/screens/login.dart';
import 'package:farmertoconsumer/screens/order/order.dart';
import 'package:farmertoconsumer/screens/product_management.dart';
import 'package:farmertoconsumer/screens/product_upload.dart';
import 'package:farmertoconsumer/screens/product.dart';
import 'package:farmertoconsumer/screens/registration.dart';
import 'package:farmertoconsumer/screens/user_upgrade_form.dart';
import 'package:farmertoconsumer/screens/user_upgrade.dart';

import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:farmertoconsumer/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => FeedDataProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const FeedScreen(),
          Routes.feed: (context) => FeedScreen(),
          Routes.login: (context) => LoginScreen(),
          Routes.registration: (context) => RegistrationScreen(),
          Routes.order: (context) => OrderScreen(orderId: '1'),
          Routes.profile: (context) => ProfileScreen(),
          Routes.productManagement: (context) => ProductManagementScreen(),
          Routes.productUpload: (context) => ProductUploadScreen(),
          Routes.userUpgrade: (context) => UserUpgradeScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == Routes.product) {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => ProductScreen(id: args?['id'] ?? "1"),
            );
          }
          return null;
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const FeedScreen(),
        ),
      ),
    );
  }
}