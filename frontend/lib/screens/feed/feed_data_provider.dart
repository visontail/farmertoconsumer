import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/models/productCategory.dart';
import 'package:farmertoconsumer/services/category_service.dart';
import 'package:farmertoconsumer/services/product_service.dart';
import 'package:flutter/material.dart';

const productsPerPage = 5;

class FeedDataProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();

  List<ProductCategory> _categories = [];
  List<Product> _products = [];
  bool _productsLoading = true;
  bool _categoriesLoading = true;
  bool _hasMoreProduct = false;

  String? _productSearchQuery;
  int? _selectedCategoryId;
  int _loadedPage = 0;

  FeedDataProvider() {
    reloadProducts();

    _categoryService.getAll().then((v) {
      _categories = v.data;
      _categoriesLoading = false;
      notifyListeners();
    });
  }

  List<ProductCategory> get categories => _categories;
  List<Product> get products => _products;
  bool get productsLoading => _productsLoading;
  bool get categoriesLoading => _categoriesLoading;
  bool get hasMoreProduct => _hasMoreProduct;
  int? get selectedCategoryId => _selectedCategoryId;

  void reloadProducts() {
    _productsLoading = true;
    notifyListeners();

    _productService
        .getAll(_productSearchQuery, _selectedCategoryId, 0, productsPerPage)
        .then((v) {
      _products = v.data;

      _productsLoading = false;
      _loadedPage = 1;
      _hasMoreProduct = _loadedPage * productsPerPage < v.total;
      notifyListeners();
    });
  }

  void loadMoreProduct() {
    _productsLoading = true;
    notifyListeners();

    _productService
        .getAll(_productSearchQuery, _selectedCategoryId,
            _loadedPage * productsPerPage, productsPerPage)
        .then((v) {
      _products = [..._products, ...v.data];
      _productsLoading = false;
      _loadedPage++;
      _hasMoreProduct = _loadedPage * productsPerPage < v.total;
      notifyListeners();
    });
  }

  void searchProduct(String? searchQuery) {
    _productSearchQuery = searchQuery;
    reloadProducts();
  }

  void selectCategory(int? categoryId) {
    _selectedCategoryId = categoryId;
    reloadProducts();
  }
}
