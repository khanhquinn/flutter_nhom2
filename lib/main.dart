import 'package:flutter/material.dart';
//import 'package:flutter_nhom2/Product.dart';
//import 'package:flutter_nhom2/tinh_chi_so_BMI.dart';

//import 'phan_hoi.dart';
//import 'package:flutter_nhom2/dang_ky.dart';
//import 'package:flutter_nhom2/dang_nhap.dart';
//import 'package:flutter_nhom2/change_color_app.dart';
//import 'home_page.dart';
//import 'my_school.dart';
//import 'package:flutter_nhom2/change_color_app.dart';
//import 'package:flutter_nhom2/counter_app.dart';
//import 'package:flutter_nhom2/my_screen.dart';
//import 'package:flutter_nhom2/my_product.dart';
//import 'package:flutter_nhom2/API.dart';
//import 'package:flutter_nhom2/product_page.dart';
//import 'package:flutter_nhom2/API_1.dart';
//import 'package:flutter_nhom2/arctical.dart';
//import 'package:flutter_nhom2/my_product.dart';
//import 'package:flutter_nhom2/product_page.dart';
//import 'package:flutter_nhom2/profile_screen.dart';
//import 'dang_nhap.dart';
import 'tong_ket_cuoi_nam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Access",
      home: TongKetCuoiNam(),
    );
  }
}
