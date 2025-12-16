import 'dart:convert';

class Product {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',

      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      description: json['description'] ?? 'No description available.',
      category: json['category'] ?? 'Uncategorized',
      image: json['image'] ?? 'https://via.placeholder.com/150',
    );
  }
}
