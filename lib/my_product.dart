import 'package:flutter/material.dart';
import 'package:flutter_nhom2/API.dart';
import 'package:flutter_nhom2/product.dart';
import 'package:flutter_nhom2/product_detail-screen.dart';
import 'package:flutter_nhom2/cart_service.dart';
import 'package:flutter_nhom2/cart_screen.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  late Future<List<Product>> _productsFuture;
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _productsFuture = testApi.getAllProduct();
    // Sau khi tải dữ liệu lần đầu, lưu vào _allProducts và áp dụng bộ lọc
    _productsFuture.then((products) {
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
      });
    });
    // Lắng nghe sự thay đổi của ô tìm kiếm
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // === CHỨC NĂNG TÌM KIẾM VÀ LỌC ===
  void _filterProducts() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      // 1. Lọc theo văn bản tìm kiếm trên toàn bộ danh sách sản phẩm
      List<Product> searchResults = _allProducts.where((product) {
        return product.title.toLowerCase().contains(query);
      }).toList();

      // 2. Lọc tiếp theo danh mục (nếu có)
      if (_selectedCategory != null) {
        // Áp dụng bộ lọc danh mục đã chọn (dựa trên tiêu đề hoặc category)
        final filterText = _selectedCategory!.toLowerCase();
        _filteredProducts = searchResults.where((product) {
          // Kiểm tra xem tiêu đề hoặc category có chứa từ khóa lọc nhanh không
          return product.title.toLowerCase().contains(filterText) ||
              product.category.toLowerCase().contains(filterText);
        }).toList();
      } else {
        // Nếu không có lọc nhanh, sử dụng kết quả tìm kiếm
        _filteredProducts = searchResults;
      }
    });
  }

  // === WIDGET LỰA CHỌN NHANH (Sử dụng Wrap để tự động xuống dòng) ===
  Widget _buildQuickFilters() {
    const List<String> categories = [
      "SSD",
      "Gold",
      "Gaming",
      "Women",
      "Men",
      "inches",
      "USB",
      "backpack",
    ];

    return Padding(
      // Giảm padding trên dưới để Chip vừa vặn
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0, // Khoảng cách giữa các hàng
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return ActionChip(
            label: Text(category),
            backgroundColor: isSelected
                ? Colors.blueAccent
                : Colors.grey.shade200,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            onPressed: () {
              setState(() {
                // Nếu đang chọn, nhấn lần nữa để hủy chọn
                _selectedCategory = isSelected ? null : category;
                _searchController
                    .clear(); // Xoá tìm kiếm bằng văn bản khi dùng lọc nhanh
                _filterProducts();
              });
            },
          );
        }).toList(),
      ),
    );
  }
  // =============================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Sản Phẩm'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,

        // --- THANH TÌM KIẾM (Chỉ chứa ô tìm kiếm) ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm sản phẩm...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),

        // --- BIỂU TƯỢNG GIỎ HÀNG ---
        actions: [
          AnimatedBuilder(
            animation: cartService,
            builder: (context, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  if (cartService.totalItems > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          cartService.totalItems.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // --- BODY: CÁC MỤC LỌC NHANH + DANH SÁCH SẢN PHẨM ---
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. VÙNG LỰA CHỌN NHANH (Tách biệt)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 8.0),
            child: Text(
              'Lọc nhanh:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          _buildQuickFilters(),

          const Divider(height: 10, thickness: 1),

          // 2. DANH SÁCH SẢN PHẨM
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Lỗi tải dữ liệu: ${snap.error}'));
                }
                if (snap.hasData) {
                  return mylistview(_filteredProducts);
                }
                return const Center(
                  child: Text('Không tìm thấy sản phẩm nào.'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget mylistview(List<Product> ls) {
    if (ls.isEmpty) {
      return const Center(child: Text('Không có kết quả tìm kiếm/lọc.'));
    }
    return ListView.builder(
      itemCount: ls.length,
      itemBuilder: (context, index) {
        return myItem(ls[index], context);
      },
    );
  }

  Widget myItem(Product p, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          // Chức năng chuyển sang màn hình chi tiết
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: p),
              ),
            );
          },
          leading: SizedBox(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(p.image, fit: BoxFit.cover),
            ),
          ),
          title: Text(
            p.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            '\$${p.price.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
