import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef SearchCallback = void Function(String);

class FeedSearch extends StatefulWidget {
  FeedSearch({super.key});

  @override
  _FeedSearchState createState() => _FeedSearchState();
}

class _FeedSearchState extends State<FeedSearch> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);
    return Row(children: [
      Expanded(
          child: TextField(
        controller: searchController,
        onSubmitted: provider.searchProduct,
        decoration: const InputDecoration(
          hintText: 'Search',
        ),
      )),
      Expanded(
          child: ElevatedButton(
              onPressed: () {
                provider.searchProduct(null);
              },
              child: const Text("Reset")))
    ]);
  }
}
