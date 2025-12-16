import 'package:flutter/material.dart';

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
