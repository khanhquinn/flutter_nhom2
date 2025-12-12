// lib/API.dart
import 'package:dio/dio.dart';
import 'package:flutter_nhom2/product.dart';

class Api {
  Future<List<Product>> getAllProduct() async {
    var dio = Dio();
    var url = 'https://fakestoreapi.com/products';

    try {
      var response = await dio.get(url);

      if (response.statusCode == 200) {
        List data = response.data as List;
        List<Product> ls = data.map((json) => Product.fromJson(json)).toList();
        return ls;
      } else {
        print('Lỗi: StatusCode = ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Lỗi kết nối Dio: $e');
      return [];
    } catch (e) {
      print('Lỗi không xác định: $e');
      return [];
    }
  }
}

var testApi = Api();
