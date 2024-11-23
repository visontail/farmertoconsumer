import 'package:farmertoconsumer/screens/feed/components/feed-categories.dart';
import 'package:farmertoconsumer/screens/feed/components/feed-products.dart';
import 'package:farmertoconsumer/screens/feed/components/feed-search.dart';
import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: provider.refresh,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/icon.svg',
                                    width: 40,
                                    color: mainGreen,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        "Welcome",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ))
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                'assets/icons/profile.svg',
                                width: 25,
                                color: mainGreen,
                              ))
                        ])),
                FeedSearch(),
                const Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                FeedCategories(),
                const Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                FeedProducts()
              ],
            )));
  }
}
