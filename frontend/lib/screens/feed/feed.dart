import 'package:farmertoconsumer/providers/auth_provider.dart';
import 'package:farmertoconsumer/utils/routes.dart';
import 'package:farmertoconsumer/widgets/feed/product_card.dart';
import 'package:farmertoconsumer/widgets/feed/category_card.dart';
import 'package:farmertoconsumer/widgets/feed/search_text_field.dart';
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
                appBarWidget(context),
                SearchTextField(
                    search: provider.searchProduct,
                    controller: searchController),
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
                productsWidget(context)
              ],
            )));
  }

  Widget appBarWidget(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    onSelectProfile() {
      if (authProvider.isAuthenticated) {
        if (authProvider.user!.isProducer) {
          Navigator.pushNamed(context, Routes.producerProfile);
        } else {
          Navigator.pushNamed(context, Routes.consumerProfile);
        }
      } else {
        Navigator.pushNamed(context, Routes.login);
      }
    }

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
            child: InkWell(
                onTap: onSelectProfile,
                child: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  width: 25,
                  color: mainGreen,
                )),
          )
        ]));
  }

  Widget categoriesWidget(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: provider.categoriesLoading && provider.categories.isEmpty
                ? [const CircularProgressIndicator()]
                : provider.categories.map((ProductCategory category) {
                    return CategoryCard(
                        category: category,
                        selectCategory: (id) => provider.selectCategory(id),
                        selectedCategoryId: provider.selectedCategoryId);
                  }).toList()));
  }

  Widget productsWidget(BuildContext context) {
    final provider = Provider.of<FeedDataProvider>(context);

    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              ...provider.products.map((Product product) {
                return ProductCard(product: product);
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
