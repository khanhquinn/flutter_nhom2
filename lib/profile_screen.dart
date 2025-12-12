import 'package:flutter/material.dart';
import 'dang_nhap.dart'; // Import để quay về màn hình đăng nhập

class ProfileScreen extends StatelessWidget {
  final String accessToken;
  final Map<String, dynamic> userProfile;

  const ProfileScreen({
    super.key,
    required this.accessToken,
    required this.userProfile,
  });

  // --- HÀM XỬ LÝ ĐĂNG XUẤT ---
  void _xuLyDangXuat(BuildContext context) {
    // Điều hướng về màn hình Login và xóa tất cả các Route trước đó
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const DangNhapScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Widget helper để hiển thị từng dòng thông tin
  Widget _buildInfoRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: Colors.teal, size: 20),
            ),
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  // Widget helper để tạo phần tiêu đề lớn
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin Tài khoản'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Gói Nội dung Cuộn được vào Expanded và SingleChildScrollView ---
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // --- THÔNG TIN CƠ BẢN ---
                    _buildSectionTitle('Thông tin Chung'),
                    _buildInfoRow(
                      'Họ tên',
                      userProfile['ho_ten'] ?? 'N/A',
                      icon: Icons.badge,
                    ),
                    _buildInfoRow(
                      'Username',
                      userProfile['username'] ?? 'N/A',
                      icon: Icons.person,
                    ),
                    _buildInfoRow(
                      'Email',
                      userProfile['email'] ?? 'N/A',
                      icon: Icons.email,
                    ),
                    _buildInfoRow(
                      'Vai trò',
                      userProfile['vai_tro'] ?? 'N/A',
                      icon: Icons.security,
                    ),
                    _buildInfoRow(
                      'Địa chỉ',
                      userProfile['dia_chi_thuong_tru'] ?? 'N/A',
                      icon: Icons.location_on,
                    ),

                    // --- THÔNG TIN CÁ NHÂN CHI TIẾT ---
                    _buildSectionTitle('Dữ liệu Sinh học'),
                    _buildInfoRow(
                      'Tuổi',
                      userProfile['tuoi']?.toString() ?? 'N/A',
                      icon: Icons.cake,
                    ),
                    _buildInfoRow(
                      'Nhóm máu',
                      userProfile['nhom_mau']?.toString() ?? 'N/A',
                      icon: Icons.bloodtype,
                    ),
                    _buildInfoRow(
                      'Chiều cao',
                      '${userProfile['chieu_cao']?.toString() ?? 'N/A'} cm',
                      icon: Icons.height,
                    ),
                    _buildInfoRow(
                      'Cân nặng',
                      '${userProfile['can_nang']?.toString() ?? 'N/A'} kg',
                      icon: Icons.monitor_weight,
                    ),
                    _buildInfoRow(
                      'Màu tóc',
                      '${userProfile['mau_toc']} (${userProfile['kieu_toc']})' ??
                          'N/A',
                      icon: Icons.content_cut,
                    ),

                    // --- THÔNG TIN CÔNG VIỆC ---
                    _buildSectionTitle('Công việc'),
                    _buildInfoRow(
                      'Công ty',
                      userProfile['ten_cong_ty'] ?? 'N/A',
                      icon: Icons.business,
                    ),
                    _buildInfoRow(
                      'Phòng ban',
                      userProfile['phong_ban'] ?? 'N/A',
                      icon: Icons.group,
                    ),
                    _buildInfoRow(
                      'Chức danh',
                      userProfile['chuc_danh'] ?? 'N/A',
                      icon: Icons.work,
                    ),

                    const Divider(height: 30),

                    // --- ACCESS TOKEN ---
                    const Text(
                      'Access Token (Mô phỏng - Không hiển thị trong thực tế):',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        accessToken,
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ), // Khoảng cách cuối nội dung cuộn
                  ],
                ),
              ),
            ),

            // --- Nút Logout (Giữ cố định ở dưới cùng) ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _xuLyDangXuat(context),
                icon: const Icon(Icons.logout),
                label: const Text('Đăng xuất', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
