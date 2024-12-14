import 'dart:typed_data';

import 'package:farmertoconsumer/models/product.dart';
import 'package:farmertoconsumer/utils/api_endpoints.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<Uint8List> getProductImage(Product product) async {
  final response = await http.get(Uri.parse('$productImageDownloadEndpoint${product.id}.jpg'));

  if (response.statusCode != 200) {
    final ByteData data = await rootBundle.load('assets/images/${product.category.name}.jpg');
    return data.buffer.asUint8List();
  }
  else {
    return response.bodyBytes;
  }
}