// File: product_detail_page.dart

import 'package:flutter/material.dart';
import 'product_1.dart';
import 'package:intl/intl.dart';
// Import CartModel
//import 'cart_model.dart';

// Định nghĩa kiểu cho Callback Function
typedef AddToCartCallback = void Function(Product product);

class ProductDetailPage extends StatelessWidget {
  final Product product;
  // Tham số Callback mới
  final AddToCartCallback onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart, // <-- Thêm vào Constructor
  });

  @override
  Widget build(BuildContext context) {
    // Định dạng tiền tệ
    final currencyFormat = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: ' đ',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết sản phẩm')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HÀNG 1: TÊN SẢN PHẨM ĐẦY ĐỦ
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // HÀNG 2: GIÁ TIỀN
            Text(
              currencyFormat.format(product.price),
              style: const TextStyle(
                fontSize: 22,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // HÀNG 3: ĐÁNH GIÁ (SỐ SAO)
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const Icon(Icons.star_half, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Text('4.5/5 (${product.quantitySold} đánh giá)'),
              ],
            ),
            const SizedBox(height: 16),

            // HÀNG 4: ẢNH SẢN PHẨM
            Center(
              child: Image.asset(
                product.image,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),

            // HÀNG 5: MÔ TẢ SẢN PHẨM
            const Text(
              'Mô tả sản phẩm',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),

      // Nút Mua Ngay và Thêm vào giỏ
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // GỌI HÀM CALLBACK TỪ TRANG CHA KHI NHẤN NÚT
                  onAddToCart(product);
                  // Quay lại trang trước (ProductPage)
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Colors.purple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Thêm vào giỏ',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Mua Ngay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
