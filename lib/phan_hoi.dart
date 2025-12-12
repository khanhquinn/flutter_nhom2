import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhanHoi extends StatefulWidget {
  const PhanHoi({super.key});

  @override
  State<PhanHoi> createState() => _PhanHoiState();
}

class _PhanHoiState extends State<PhanHoi> {
  final _nameController = TextEditingController();
  final _contentController = TextEditingController();
  final _fileController = TextEditingController();

  int _selectedRating = 4;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  // Hàm chọn ảnh
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        // Xử lý tên file (XFile.name có sẵn)
        _fileController.text = pickedFile.name;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Gửi phản hồi",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Họ tên",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Dropdown sao
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              child: DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Đánh giá (1 - 5 sao)",
                ),
                value: _selectedRating,
                items: [1, 2, 3, 4, 5].map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text("$value sao"),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedRating = value!),
              ),
            ),

            const SizedBox(height: 15),

            // Nội dung góp ý
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Nội dung góp ý",
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 15),

            // Ô để upload/đính kèm ảnh (readOnly, mở picker khi nhấn nút)
            TextField(
              controller: _fileController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Ảnh đính kèm",
                hintText: "Chưa có ảnh",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.upload_file),
                  onPressed: _pickImage,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Hiển thị ảnh đã chọn (nếu có)
            if (_selectedImage != null)
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Nút gửi phản hồi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  // Ví dụ: show thông báo, có thể thay bằng logic gửi lên server
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Đã gửi phản hồi!")),
                  );
                },
                child: const Text(
                  "Gửi phản hồi",
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
