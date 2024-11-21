import 'package:farmertoconsumer/screens/feed/components/feed-categories.dart';
import 'package:farmertoconsumer/screens/feed/components/feed-products.dart';
import 'package:farmertoconsumer/screens/feed/components/feed-search.dart';
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
            FeedProducts()
          ],
        ));
  }
}
