import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:farmertoconsumer/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef SelectCategoryCallback = void Function(int);

class FeedProducts extends StatefulWidget {
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);

    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              ...provider.products.map((Product product) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Container(
                      margin: const EdgeInsets.all(7),
                      height: 100,
                      decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]),
                      child: Center(
                        child: Text(product.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            overflow: TextOverflow.clip,
                            softWrap: false),
                      ),
                    ));
              }).toList(),
              ElevatedButton(
                  onPressed: provider.hasMoreProduct
                      ? () {
                          provider.loadMoreProduct();
                        }
                      : null,
                  child: const Text("Load more"))
            ])));
  }
}
