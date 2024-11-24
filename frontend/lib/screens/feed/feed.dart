import 'package:farmertoconsumer/screens/feed/components/feed-categories.dart';
import 'package:farmertoconsumer/screens/feed/components/feed-products.dart';
import 'package:farmertoconsumer/screens/feed/components/feed-search.dart';
import 'package:farmertoconsumer/utils/routes.dart';
import 'package:farmertoconsumer/widgets/nav_button_simple.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: Column(
          children: [
            FeedSearch(),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            FeedCategories(),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            FeedProducts(),
            NavigationButton(
          routeName: Routes.login,
          buttonText: 'Go to Login',
        ),
        NavigationButton(
          routeName: Routes.registration,
          buttonText: 'Go to Registration',
        ),
        NavigationButton(
          routeName: Routes.consumerProfile,
          buttonText: 'Go to Consumer Profile',
        ),
        NavigationButton(
          routeName: Routes.producerProfile,
          buttonText: 'Go to Producer Profile',
        ),],
        ));
  }
}
