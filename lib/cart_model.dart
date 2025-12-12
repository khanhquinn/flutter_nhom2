// File: cart_model.dart

import 'product_1.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // Tăng số lượng sản phẩm trong giỏ
  void incrementQuantity() {
    quantity++;
  }

  // Tổng tiền của món hàng này
  double get total => product.price * quantity;
}

// Danh sách Giỏ hàng tĩnh (Shopping Cart)
List<CartItem> shoppingCart = [];
