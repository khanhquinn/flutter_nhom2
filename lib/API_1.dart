import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String apiUrl = "https://fakestoreapi.com/products";

  static Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }
}
