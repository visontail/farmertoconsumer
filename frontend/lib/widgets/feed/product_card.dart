import 'dart:typed_data';
import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:farmertoconsumer/utils/asset_helper.dart';
import 'package:farmertoconsumer/utils/routes.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
        child: Container(
            decoration: BoxDecoration(
                color: mainGreen, borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FutureBuilder(
                                future: getProductImage(product),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Uint8List> snapshot) {
                                  if (snapshot.hasData) {
                                    return Image.memory(snapshot.data!,
                                        width: 180,
                                        height: 100,
                                        fit: BoxFit.cover);
                                  } else {
                                    return SizedBox(
                                        width: 180,
                                        height: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(color: Colors.white),
                                        ));
                                  }
                                })),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.product,
                                arguments: {'id': '${product.id}'});
                          },
                          child: const Row(
                            children: [
                              Text(
                                "View ",
                                style: TextStyle(color: Colors.white),
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
  }
}
