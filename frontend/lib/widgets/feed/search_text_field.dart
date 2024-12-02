import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final Function(String?) search;
  final TextEditingController controller;

  const SearchTextField({
    super.key,
    required this.search,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          width: 200,
          child: TextField(
            controller: controller,
            onSubmitted: search,
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Icon(
                    Icons.search,
                    color: mainGreen,
                    opticalSize: 15,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainGreen, width: 2.0)),
            ),
          )),
      if (controller.text != "")
        TextButton(
            onPressed: () {
              search(null);
              controller.text = "";
            },
            child: const Icon(
              Icons.clear,
              color: mainGreen,
              size: 15,
            ))
    ]);
  }
}
