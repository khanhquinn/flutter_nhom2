// File: product_page.dart

import 'package:flutter/material.dart';
import 'product_1.dart';
import 'package:intl/intl.dart';
import 'product_detail_page.dart';
// Import Cart Model và Cart Page
import 'cart_model.dart';
import 'cart_page.dart';

// Delegate để cố định (pin) khu vực Tìm kiếm và Danh mục
class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget searchAndCategoryWidget;
  final double minHeight;
  final double maxHeight;

  const _PinnedHeaderDelegate({
    required this.searchAndCategoryWidget,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: searchAndCategoryWidget);
  }

  @override
  bool shouldRebuild(_PinnedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Danh sách gốc (không đổi)
  final List<Product> allProducts = products;

  // Danh sách hiển thị (thay đổi khi tìm kiếm)
  late List<Product> filteredProducts;

  // Controller để quản lý ô nhập liệu tìm kiếm
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  // HÀM LỌC SẢN PHẨM
  void _filterProducts() {
    final keyword = _searchController.text.toLowerCase();

    setState(() {
      if (keyword.isEmpty) {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where((product) => product.name.toLowerCase().contains(keyword))
            .toList();
      }
    });
  }

  // HÀM THÊM SẢN PHẨM VÀO GIỎ
  void _addToCart(Product product) {
    setState(() {
      // 1. Kiểm tra xem sản phẩm đã có trong giỏ chưa
      int index = shoppingCart.indexWhere(
        (item) => item.product.name == product.name,
      );

      if (index != -1) {
        // 2. Nếu đã có, tăng số lượng
        shoppingCart[index].incrementQuantity();
      } else {
        // 3. Nếu chưa có, thêm mới vào giỏ
        shoppingCart.add(CartItem(product: product));
      }
    });

    // Hiển thị thông báo (Snackbar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm ${product.name} vào giỏ hàng!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Hàm xây dựng Chip danh mục
  Widget _buildCategoryChip(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        avatar: Icon(icon, color: Colors.blue),
        label: Text(title),
        backgroundColor: Colors.blue.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
    );
  }

  // Hàm xây dựng khối Tìm kiếm và Danh mục
  Widget _buildSearchAndCategories() {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Ô TÌM KIẾM
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                  filled: true,
                  fillColor: Color(0xFFE0E0E0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ),

          // 2. CÁC CHIP DANH MỤC
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildCategoryChip("Bài Tarot", Icons.card_membership),
                _buildCategoryChip("Khăn trải bàn", Icons.table_chart),
                _buildCategoryChip("Đá thanh tẩy", Icons.diamond),
                _buildCategoryChip(
                  "Trầm thanh tẩy",
                  Icons.local_fire_department,
                ),
                _buildCategoryChip("Sách hướng dẫn", Icons.book),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double pinnedHeight = 160.0;

    final currencyFormat = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: ' đ',
      decimalDigits: 0,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // 1. APP BAR (Banner)
            SliverAppBar(
              expandedHeight: 180.0,
              pinned: false,
              floating: true,
              backgroundColor: Colors.transparent,
              elevation: 0,

              actions: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Center(
                    child: Text(
                      "Xin chào, Khánh Quỳnh",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                // Nút GIỎ HÀNG có số lượng
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ),
                        );
                        // Cập nhật trạng thái (số lượng) khi quay lại từ CartPage
                        setState(() {});
                      },
                    ),
                    // Badge hiển thị số lượng sản phẩm trong giỏ
                    if (shoppingCart.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            shoppingCart.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],

              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/banner_1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2. HEADER CỐ ĐỊNH (Tìm kiếm & Danh mục)
            SliverPersistentHeader(
              pinned: true,
              delegate: _PinnedHeaderDelegate(
                searchAndCategoryWidget: _buildSearchAndCategories(),
                minHeight: pinnedHeight,
                maxHeight: pinnedHeight,
              ),
            ),

            // 3. DANH SÁCH SẢN PHẨM (Grid)
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final item = filteredProducts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: item,
                            onAddToCart: _addToCart, // <-- TRUYỀN CALLBACK
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HÀNG 1: ĐÃ BÁN
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 4.0,
                                top: 4.0,
                                bottom: 4.0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "Đã bán: ${item.quantitySold}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),

                          // HÀNG 2: ẢNH SẢN PHẨM
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),

                          // HÀNG 3: TÊN SẢN PHẨM
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4.0,
                              right: 4.0,
                              top: 4.0,
                            ),
                            child: Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 4),

                          // HÀNG 4: GIÁ TIỀN
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4.0,
                              bottom: 4.0,
                            ),
                            child: Text(
                              currencyFormat.format(item.price),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
