import 'package:flutter/material.dart';

class DangKy extends StatefulWidget {
  const DangKy({super.key});

  @override
  State<DangKy> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<DangKy> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng ký thành công!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ===== HEADER CÓ NÚT QUAY LẠI =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  // Nút quay lại
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  // Tiêu đề
                  const Expanded(
                    child: Text(
                      'Form Đăng ký tài khoản',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Khoảng trống cân layout
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // ===== FORM =====
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Họ tên
                      _buildTextField(
                        controller: _nameController,
                        label: 'Họ tên',
                        hint: 'Vui lòng nhập họ tên',
                        icon: Icons.person_outline,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Vui lòng nhập họ tên'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Vui lòng nhập email',
                        icon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          if (!value.contains('@gmail.com')) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Mật khẩu
                      _buildPasswordField(
                        controller: _passwordController,
                        label: 'Mật khẩu',
                        hint: 'Vui lòng nhập mật khẩu',
                        isVisible: _isPasswordVisible,
                        onToggle: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          if (value.length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Xác nhận mật khẩu
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        label: 'Xác nhận mật khẩu',
                        hint: 'Vui lòng xác nhận mật khẩu',
                        isVisible: _isConfirmPasswordVisible,
                        onToggle: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng xác nhận mật khẩu';
                          }
                          if (value != _passwordController.text) {
                            return 'Mật khẩu không khớp';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Nút đăng ký
                      ElevatedButton.icon(
                        onPressed: _handleRegister,
                        icon: const Icon(Icons.person_add, size: 18),
                        label: const Text(
                          'Đăng ký',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F51B5),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== TEXT FIELD DÙNG CHUNG =====
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Color(0xFF37474F)),
      decoration: _inputDecoration(label, hint, icon),
      validator: validator,
    );
  }

  // ===== PASSWORD FIELD =====
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      style: const TextStyle(color: Color(0xFF37474F)),
      decoration: _inputDecoration(label, hint, Icons.lock_outline).copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF37474F),
          ),
          onPressed: onToggle,
        ),
      ),
      validator: validator,
    );
  }

  // ===== DECORATION CHUNG =====
  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      filled: true,
      fillColor: const Color(0xFFB2DFDB).withOpacity(0.3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
    );
  }
}
