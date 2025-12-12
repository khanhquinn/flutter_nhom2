import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ---------- 1. IMAGE ----------
        Image.network(
          'https://izitour.com/media/blog/truong-tien-bridge.webp',
          height: 240,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        // ---------- 2. TITLE SECTION ----------
        Padding(
          padding: const EdgeInsets.all(16),
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
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hue City, Viet Nam',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.star, color: Colors.red),
              const Text('41'),
            ],
          ),
        ),

        // ---------- 3. BUTTON SECTION ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ButtonColumn(icon: Icons.call, label: 'CALL'),
              _ButtonColumn(icon: Icons.near_me, label: 'ROUTE'),
              _ButtonColumn(icon: Icons.share, label: 'SHARE'),
            ],
          ),
        ),

        // ---------- 4. TEXT SECTION ----------
        const Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Trang Tien (or Truong Tien) Bridge is a historic, over-100-year-old steel bridge in Huế, Vietnam, spanning the Perfume River. '
            "Designed by Eiffel's company, it was completed in 1899 and has been a cultural icon with various names and renovations, now featuring a nighttime lighting system.",
            softWrap: true,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

// ---------- Widget phụ: Nút Icon + Text ----------
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
        Icon(icon, color: color),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
