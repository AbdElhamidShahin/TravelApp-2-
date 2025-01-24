import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.text, required this.image});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,
                width: 50, // ضبط العرض حسب الحاجة
                height: 50, // ضبط الارتفاع حسب الحاجة
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
      ],
    );
  }
}
