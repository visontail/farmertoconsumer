const String baseUrl = 'http://10.0.2.2:3000';
const String loginEndpoint = '$baseUrl/auth/login';
const String registerEndpoint = '$baseUrl/auth/register';

const String productsEndPoint = '$baseUrl/products';
const String productEndPoint = '$baseUrl/products/';

const String getAllCategoryEndpoint = '$baseUrl/categories';

const String ordersEndPoint = '$baseUrl/orders';

String getAllProductEndpoint(
    String? search, int? categoryId, int? skip, int? take) {
  String url = '$baseUrl/products?';

  if (search != null) {
    url += '&search=$search';
  }
  if (categoryId != null) {
    url += '&categoryId=$categoryId';
  }
  if (skip != null) {
    url += '&skip=$skip';
  }
  if (take != null) {
    url += '&take=$take';
  }

  return url;
}
