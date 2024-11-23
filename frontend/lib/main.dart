import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/feed/feed.dart';
import '../screens/consumer_profile.dart';
import '../screens/login.dart';
import '../screens/order_confirmation.dart';
import '../screens/order.dart';
import '../screens/producer_profile.dart';
import '../screens/product_management.dart';
import '../screens/product_upload.dart';
import '../screens/product.dart';
import '../screens/registration.dart';
import '../screens/user_upgrade_form.dart';
import '../screens/user_upgrade.dart';

import '../services/auth_service.dart';
import '../services/product_service.dart';
import '../screens/feed/feed_data_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => FeedDataProvider()),
        ChangeNotifierProvider(create: (context) => ProductService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/feed', // Default route
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Route<dynamic>? onGenerateRoute(settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/registration':
            return MaterialPageRoute(builder: (context) => RegistrationScreen());
          case '/feed':
            return MaterialPageRoute(builder: (context) => FeedScreen());
          case '/order':
            return MaterialPageRoute(builder: (context) => OrderScreen());
          case '/order_confirmation':
            return MaterialPageRoute(builder: (context) => OrderConfirmationScreen());
          case '/consumer_profile':
            return MaterialPageRoute(builder: (context) => ConsumerProfileScreen());
          case '/producer_profile':
            return MaterialPageRoute(builder: (context) => ProducerProfileScreen());
          case '/product_management':
            return MaterialPageRoute(builder: (context) => ProductManagementScreen());
          case '/product_upload':
            return MaterialPageRoute(builder: (context) => ProductUploadScreen());
          case '/product':
            final arguments = settings.arguments as Map<String, String>?;
            final id = arguments?['id'] ?? 'default';
            return MaterialPageRoute(
              builder: (context) => ProductScreen(id: id), // Pass id to ProductScreen
            );
          case '/user_upgrade':
            return MaterialPageRoute(builder: (context) => UserUpgradeScreen());
          case '/user_upgrade_form':
            return MaterialPageRoute(builder: (context) => UserUpgradeFormScreen());
          default:
            return MaterialPageRoute(builder: (context) => FeedScreen()); // Fallback route
        }
      }
}
