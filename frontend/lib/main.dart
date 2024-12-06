import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmertoconsumer/services/product_service.dart';

import '../screens/feed/feed.dart';
import 'screens/profile/profile.dart';
//import '../screens/consumer_profile.dart';
import '../screens/login.dart';
//import '../screens/order_confirmation.dart';
import 'screens/order/order.dart';
//import '../screens/producer_profile.dart';
import '../screens/product_management.dart';
import '../screens/product_upload.dart';
import '../screens/product.dart';
import '../screens/registration.dart';
//import '../screens/user_upgrade_form.dart';
import '../screens/user_upgrade.dart';

import '../screens/feed/feed_data_provider.dart';
import '../utils/routes.dart';

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
        ChangeNotifierProvider(create: (context) => FeedDataProvider()),
        //ChangeNotifierProvider(create: (context) => ProductService()),
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
          //Routes.orderConfirmation: (context) => OrderConfirmationScreen(),
          Routes.profile: (context) => ProfileScreen(),
          //Routes.consumerProfile: (context) => ConsumerProfileScreen(),
          //Routes.producerProfile: (context) => ProducerProfileScreen(),
          Routes.productManagement: (context) => ProductManagementScreen(),
          Routes.productUpload: (context) => ProductUploadScreen(),
          Routes.userUpgrade: (context) => UserUpgradeScreen(),
          //Routes.userUpgradeForm: (context) => UserUpgradeFormScreen(),
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