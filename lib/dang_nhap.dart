// import 'package:flutter/material.dart';

// class DangNhapScreen extends StatefulWidget {
//   const DangNhapScreen({super.key});

//   @override
//   State<DangNhapScreen> createState() => _DangNhapScreenState();
// }

// class _DangNhapScreenState extends State<DangNhapScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _tenController = TextEditingController();
//   final _matkhauController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Form Đăng nhập"),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _tenController,
//                   decoration: const InputDecoration(
//                     labelText: 'Tên người dùng',
//                     hintText: 'Vui lòng nhập tên người dùng',
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Tên người dùng không được để trống';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 // Mật khẩu
//                 TextFormField(
//                   controller: _matkhauController,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     labelText: 'Mật khẩu',
//                     hintText: 'Vui lòng nhập mật khẩu',
//                     prefixIcon: const Icon(Icons.lock),
//                     border: const OutlineInputBorder(),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Mật khẩu không được để trống';
//                     } else if (value.length < 6) {
//                       return 'Mật khẩu phải có ít nhất 6 ký tự';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 30),
//                 // Nút đăng nhập
//                 Align(
//                   alignment: Alignment.center,
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 30,
//                         vertical: 12,
//                       ),
//                       backgroundColor: Colors.blueAccent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Đăng nhập thành công'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       }
//                     },
//                     icon: const Icon(Icons.login),
//                     label: const Text(
//                       'Đăng nhập',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Import màn hình profile

class DangNhapScreen extends StatefulWidget {
  const DangNhapScreen({super.key});

  @override
  State<DangNhapScreen> createState() => _DangNhapScreenState();
}

class _DangNhapScreenState extends State<DangNhapScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tenController = TextEditingController();
  final _matkhauController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _tenController.dispose();
    _matkhauController.dispose();
    super.dispose();
  }

  // --- HÀM XỬ LÝ ĐĂNG NHẬP ---
  Future<void> _xuLyDangNhap() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Bắt đầu loading
      });

      // Mô phỏng API call
      await Future.delayed(const Duration(seconds: 2));

      const String tenDung = 'emlily';
      const String matKhauDung = 'emilypass';

      if (_tenController.text == tenDung &&
          _matkhauController.text == matKhauDung) {
        // Đăng nhập thành công
        const String accessToken =
            'mocked_jwt_token_as_access_1234567890_abcdef';

        // --- DỮ LIỆU PROFILE CHI TIẾT DỰA TRÊN JSON BẠN CUNG CẤP ---
        final Map<String, dynamic> userProfile = {
          'id': 1,
          'ho_ten': 'Emily Johnson',
          'ten_thoi_con_gai': 'Smith',
          'tuoi': 29,
          'username': _tenController.text, // Lấy từ input
          'email': 'emily.johnson@x.dummyjson.com',
          'nhom_mau': 'O-',
          'chieu_cao': 193.24,
          'can_nang': 63.16,
          'mau_mat': 'Green',
          'mau_toc': 'Brown',
          'kieu_toc': 'Curly',

          'dia_chi_thuong_tru': '626 Main Street, Phoenix, Mississippi, US',

          'ten_cong_ty': 'Dooley, Kozey and Cronin',
          'phong_ban': 'Engineering',
          'chuc_danh': 'Sales Manager',
          'vai_tro': 'admin',
        };
        // -----------------------------------------------------------

        // Chuyển sang màn hình Profile và xóa các route trước đó
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              accessToken: accessToken,
              userProfile: userProfile,
            ),
          ),
        );
      } else {
        // Đăng nhập thất bại
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tên người dùng hoặc mật khẩu không đúng. Thử: test / 123456',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _isLoading = false; // Kết thúc loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Đăng nhập"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Chào mừng, vui lòng đăng nhập',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 40),
                // Trường Tên người dùng
                TextFormField(
                  controller: _tenController,
                  decoration: const InputDecoration(
                    labelText: 'Tên người dùng',
                    hintText: 'Nhập "test" để thử',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên người dùng không được để trống';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Trường Mật khẩu
                TextFormField(
                  controller: _matkhauController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    hintText: 'Nhập "123456" để thử',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mật khẩu không được để trống';
                    } else if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                // Nút đăng nhập
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _isLoading ? null : _xuLyDangNhap,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.login),
                  label: Text(
                    _isLoading ? 'Đang xử lý...' : 'Đăng nhập',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
