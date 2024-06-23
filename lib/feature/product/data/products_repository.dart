import 'dart:convert';

import 'package:feedback_demo/feature/product/data/model/product.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
