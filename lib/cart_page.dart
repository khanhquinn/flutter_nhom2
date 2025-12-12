// File: cart_page.dart

import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Định dạng tiền tệ
  final currencyFormat = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: ' đ',
    decimalDigits: 0,
  );

  // Tính tổng tiền giỏ hàng
  double _calculateTotal() {
    return shoppingCart.fold(0.0, (sum, item) => sum + item.total);
  }

  // Hàm xóa sản phẩm khỏi giỏ
  void _removeItem(CartItem item) {
    setState(() {
      shoppingCart.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng của bạn')),
      body: shoppingCart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Giỏ hàng trống!',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Tiếp tục mua sắm'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // DANH SÁCH SẢN PHẨM
                Expanded(
                  child: ListView.builder(
                    itemCount: shoppingCart.length,
                    itemBuilder: (context, index) {
                      final item = shoppingCart[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            item.product.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.product.name),
                          subtitle: Text(
                            // Hiển thị giá tiền x số lượng
                            '${currencyFormat.format(item.product.price)} x ${item.quantity}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(item),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // TỔNG TIỀN VÀ NÚT THANH TOÁN
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng cộng:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            currencyFormat.format(_calculateTotal()),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Xử lý thanh toán
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Chức năng Thanh toán đang được phát triển!',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Tiến hành Thanh toán',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
