import 'package:farmertoconsumer/utils/routes.dart';
import 'package:farmertoconsumer/widgets/nav_button_simple.dart';
import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/models/productCategory.dart';
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
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);

    return Scaffold(
        body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: provider.refresh,
            child: Column(
              children: [
                appBarWidget(),
                searchWidget(context),
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
                categoriesWidget(context),
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
                productsWidget(context),
                NavigationButton(
                  routeName: Routes.login,
                  buttonText: 'Go to Login',
                ),
                NavigationButton(
                  routeName: Routes.registration,
                  buttonText: 'Go to Registration',
                )
              ],
            )));
  }

  Widget appBarWidget() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        ]));
  }

  Widget searchWidget(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          width: 200,
          child: TextField(
            controller: searchController,
            onSubmitted: provider.searchProduct,
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

  Widget categoriesWidget(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);

    capitalizeFirstChar(String text) {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1);
    }

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: provider.categoriesLoading && provider.categories.isEmpty
                ? [const CircularProgressIndicator()]
                : provider.categories.map((ProductCategory category) {
                    return GestureDetector(
                      onTap: () {
                        if (provider.selectedCategoryId == category.id) {
                          provider.selectCategory(null);
                        } else {
                          provider.selectCategory(category.id);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            color: category.id == provider.selectedCategoryId
                                ? lightGreen
                                : mainGreen,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ]),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TODO - fallback svg
                            SvgPicture.asset(
                              'assets/icons/${category.name}.svg',
                              width: 30,
                              color: Colors.white,
                            ),
                            Text(capitalizeFirstChar(category.name),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.clip,
                                softWrap: false),
                          ],
                        )),
                      ),
                    );
                  }).toList()));
  }

  Widget productsWidget(BuildContext context) {
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
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.product,
                                            arguments: {'id': '${product.id}'});
                                      },
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
              if (!provider.productsLoading && provider.products.isEmpty)
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
