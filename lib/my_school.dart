import 'package:flutter/material.dart';

class MySchool extends StatelessWidget {
  const MySchool({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> classes = [
      {
        'title': 'XML và ứng dụng - Nhóm 1',
        'code': '2025-2026.1.TIN4583.001',
        'students': 58,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJQQR09quqpIvzp5F03JHT1mH5w4fk-9UEfw&s',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.006',
        'students': 55,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTua2iugS6gAFIqDBm7Ny2TK2lsNF_cd3TLvA&s',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.005',
        'students': 52,
        'color': Colors.orangeAccent.shade100,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-8Jzu1SGC8MkSVmsTceeErdHIAGfNKu4X4Q&s',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.004',
        'students': 50,
        'color': Colors.blue.shade400,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQwohZpKglj4AUBQlMZGXxjrnMMMcmmTF97w&s',
      },
      {
        'title': 'Lập trình ứng dụng cho các thiết bị di động',
        'code': '2025-2026.1.TIN4403.003',
        'students': 58,
        'color': Colors.green.shade300,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQwohZpKglj4AUBQlMZGXxjrnMMMcmmTF97w&s',
      },
      {
        'title': 'Phát triển ứng dụng Web',
        'code': '2025-2026.1.TIN4301.002',
        'students': 60,
        'color': Colors.purple.shade200,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQwohZpKglj4AUBQlMZGXxjrnMMMcmmTF97w&s',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách lớp học'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final lop = classes[index];
          return Card(
            color: lop['color'],
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(vertical: 14),
            child: SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        lop['image'],
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.18),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    top: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lop['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          lop['code'],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    right: 20,
                    top: 16,
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 28,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 20,
                    bottom: 16,
                    child: Text(
                      '${lop['students']} học viên',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
