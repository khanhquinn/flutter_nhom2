import 'package:flutter/material.dart';
import 'package:flutter_nhom2/arctical.dart';
import 'package:flutter_nhom2/change_color_app.dart';
import 'package:flutter_nhom2/counter_app.dart';
import 'package:flutter_nhom2/dang_ky.dart';
import 'package:flutter_nhom2/dang_nhap.dart';
import 'package:flutter_nhom2/my_product.dart';
import 'package:flutter_nhom2/my_school.dart';
import 'package:flutter_nhom2/my_screen.dart';
import 'package:flutter_nhom2/phan_hoi.dart';
import 'tinh_chi_so_BMI.dart';

class TongKetCuoiNam extends StatelessWidget {
  const TongKetCuoiNam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TỔNG HỢP BÀI FLUTTER"),
        centerTitle: true,
      ),

      // ================= DRAWER MENU =================
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/menu.jpg'),
              fit: BoxFit.cover,
            ),
          ),

          child: Container(
            color: Colors.black.withOpacity(0.6), // phủ mờ
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Text(
                      "DANH SÁCH BÀI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                _menuItem(context, "Bài 1", HomePage()),
                _menuItem(context, "Bài 2", const MySchool()),
                _menuItem(context, "Bài 3", MyScreen()),
                _menuItem(context, "Bài 4", DangNhapScreen()),
                _menuItem(context, "Bài 5", DangKy()),
                _menuItem(context, "Bài 6", PhanHoi()),
                _menuItem(context, "Bài 7", TinhBMI()),
                _menuItem(context, "Bài 8", CounterApp()),
                _menuItem(context, "Bài 9", ChangeColorApp()),
                _menuItem(context, "Bài 10", const NewsListScreen()),
                _menuItem(context, "Bài 11", MyProduct()),
              ],
            ),
          ),
        ),
      ),

      // ================= BODY TRANG CHỦ =================
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/giao_dien.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // ================= MENU ITEM =================
  Widget _menuItem(BuildContext context, String title, Widget page) {
    return ListTile(
      leading: const Icon(Icons.book, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: () {
        Navigator.pop(context); // đóng menu
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}

// ================= BÀI 1 =================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Truong Tien Bridge"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // ---------- IMAGE ----------
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.network(
              'https://izitour.com/media/blog/truong-tien-bridge.webp',
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // ---------- TITLE SECTION ----------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Truong Tien Bridge',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Hue City, Viet Nam',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.star, color: Colors.red, size: 26),
                const SizedBox(width: 4),
                const Text('41', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),

          const Divider(thickness: 1),

          // ---------- BUTTON SECTION ----------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ButtonColumn(icon: Icons.call, label: 'CALL'),
                _ButtonColumn(icon: Icons.near_me, label: 'ROUTE'),
                _ButtonColumn(icon: Icons.share, label: 'SHARE'),
              ],
            ),
          ),

          const Divider(thickness: 1),

          // ---------- DESCRIPTION ----------
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Trang Tien (or Truong Tien) Bridge is a historic, over-100-year-old steel bridge in Huế, Vietnam, spanning the Perfume River. '
              "Designed by Eiffel's company, it was completed in 1899 and has been a cultural icon with various names and renovations, now featuring a nighttime lighting system.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- BUTTON COLUMN ----------
class _ButtonColumn extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ButtonColumn({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    const color = Colors.blue;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}

//=======bài 2====
