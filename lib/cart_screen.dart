// lib/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_nhom2/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng Của Bạn'),
        backgroundColor: Colors.blueGrey,
        // Tắt nút Back mặc định
        automaticallyImplyLeading: false,
        // THAY THẾ NÚT BACK BẰNG NÚT HOME
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Quay lại màn hình gốc (MyProduct)
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        // Xóa Actions nếu không muốn có thêm nút nào ở bên phải
        actions: const [],
      ),
      // AnimatedBuilder lắng nghe thay đổi của giỏ hàng
      body: AnimatedBuilder(
        animation: cartService,
        builder: (context, child) {
          final cartItems = cartService.items;
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Giỏ hàng trống. Mời bạn thêm sản phẩm!'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return buildCartItem(context, item);
                  },
                ),
              ),
              buildCartSummary(context),
            ],
          );
        },
      ),
    );
  }

  Widget buildCartItem(BuildContext context, CartItem item) {
    // ... (Code buildCartItem giữ nguyên)
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 2,
      child: ListTile(
        leading: Image.network(
          item.product.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          item.product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Giá: \$${item.product.price.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              'Tổng: \$${item.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Giảm số lượng / Xoá sản phẩm
            IconButton(
              icon: Icon(
                item.quantity > 1 ? Icons.remove : Icons.delete,
                color: item.quantity > 1 ? Colors.blue : Colors.red,
              ),
              onPressed: () {
                cartService.updateQuantity(item.product.id, item.quantity - 1);
              },
            ),
            // Số lượng
            Text(
              item.quantity.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            // Tăng số lượng
            IconButton(
              icon: const Icon(Icons.add, color: Colors.blue),
              onPressed: () {
                cartService.updateQuantity(item.product.id, item.quantity + 1);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartSummary(BuildContext context) {
    // ... (Code buildCartSummary giữ nguyên)
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng cộng:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                '\$${cartService.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Chức năng Thanh toán đang được phát triển!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'TIẾN HÀNH THANH TOÁN',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
