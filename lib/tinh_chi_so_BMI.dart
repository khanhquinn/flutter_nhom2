import 'package:flutter/material.dart';

class TinhBMI extends StatefulWidget {
  @override
  State<TinhBMI> createState() => _TinhBMIState();
}

class _TinhBMIState extends State<TinhBMI> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  double? _bmi;
  String _phanLoai = "";

  void _tinhBMI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (height <= 0 || weight <= 0) {
      setState(() {
        _bmi = null;
        _phanLoai = "Dữ liệu không hợp lệ";
      });
      return;
    }

    double bmi = weight / (height * height);

    String loai = "";
    if (bmi < 18.5) {
      loai = "Thiếu cân";
    } else if (bmi < 25) {
      loai = "Bình thường";
    } else if (bmi < 30) {
      loai = "Thừa cân";
    } else {
      loai = "Béo phì";
    }

    setState(() {
      _bmi = bmi;
      _phanLoai = loai;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tính chỉ số BMI"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Chiều cao (m)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Cân nặng (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(onPressed: _tinhBMI, child: const Text("Tính BMI")),

            const SizedBox(height: 20),

            if (_bmi != null)
              Column(
                children: [
                  Text(
                    "Chỉ số BMI: ${_bmi!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Phân loại: $_phanLoai",
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
