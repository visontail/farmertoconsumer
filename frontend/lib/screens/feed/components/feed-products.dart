import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:farmertoconsumer/styles/colors.dart';
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
                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: mainGreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                            'assets/images/prod-placeholder.jpg',
                                            width: 180,
                                            fit: BoxFit.cover)),
                                    Expanded(
                                        child: Center(
                                            child: Column(children: [
                                      Text("#${product.category.name}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                      Text("${product.price} Ft",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ]))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Row(
                                        children: [
                                          Text(
                                            "View ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ))));
              }),
              if (provider.productsLoading) const CircularProgressIndicator(),
              if (!provider.productsLoading && provider.products.length == 0)
                const Text("No product to show."),
              if (!provider.productsLoading && provider.hasMoreProduct)
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: provider.hasMoreProduct
                            ? () {
                                provider.loadMoreProduct();
                              }
                            : null,
                        child: const Text(
                          "Load more",
                          style: TextStyle(color: mainGreen),
                        ))),
            ])));
  }
}
