import 'package:flutter/material.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }

  Widget myBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item1(),
            item2(),
            item3(),
            item4(),
            // 👉 chỉ phần này cuộn
            Expanded(child: item5()),
          ],
        ),
      ),
    );
  }
}

// --- Các phần nhỏ ---
Widget item1() {
  return SizedBox(
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        IconButton(onPressed: () {}, icon: Icon(Icons.extension)),
      ],
    ),
  );
}

Widget item2() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Welcome,",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Charlie",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget item3() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search',
      ),
    ),
  );
}

Widget item4() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: const Text(
      "Saved Places",
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget item5() {
  return GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/1.png', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/2.png', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/3.png', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/4.png', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/5.jpg', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/6.jpg', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/7.jpg', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/8.jpg', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/9.png', fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/10.jpg', fit: BoxFit.cover),
      ),
    ],
  );
}
