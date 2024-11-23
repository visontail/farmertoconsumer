import 'package:farmertoconsumer/screens/feed/feed_data_provider.dart';
import 'package:farmertoconsumer/styles/colors.dart';
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
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          width: 200,
          child: TextField(
            controller: searchController,
            onSubmitted: provider.searchProduct,
            decoration: const InputDecoration(
              hintText: 'Search',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainGreen, width: 2.0)),
            ),
          )),
      if (searchController.text != "")
        TextButton(
            onPressed: () {
              provider.searchProduct(null);
              searchController.text = "";
            },
            child: const Icon(
              Icons.clear,
              color: mainGreen,
              size: 15,
            ))
    ]);
  }
}
