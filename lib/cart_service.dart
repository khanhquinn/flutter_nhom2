// lib/cart_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_nhom2/product.dart';

// Class đại diện cho một Item trong giỏ hàng
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

// Service quản lý trạng thái giỏ hàng (sử dụng ChangeNotifier)
class CartService with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  int get totalItems =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount =>
      _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(Product product, [int quantity = 1]) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        existingItem.quantity += quantity;
        return existingItem;
      });
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product, quantity: quantity),
      );
    }
    notifyListeners();
  }

  bool isInCart(Product product) {
    return _items.containsKey(product.id);
  }

  // Sửa/Xóa số lượng
  void updateQuantity(int productId, int newQuantity) {
    if (!_items.containsKey(productId)) return;

    if (newQuantity <= 0) {
      _items.remove(productId);
    } else {
      _items.update(productId, (item) {
        item.quantity = newQuantity;
        return item;
      });
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }
}

final cartService = CartService();
