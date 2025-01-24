import 'package:flutter/material.dart';

class Customtextfeild extends StatelessWidget {
   Customtextfeild(
      {super.key,
      required this.hintText,
      required this.lableText,
   this.onChanged,
      this.validator});
  final String hintText;
  final String lableText;
  Function(String)? onChanged;
  final String? Function(String?)? validator; // إضافة المعامل للـ validator

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(
          color: Colors.white, // لون النص عند الكتابة
          fontSize: 16.0, // حجم النص عند الكتابة
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: lableText,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.amber),
          ),

          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),

            borderSide: BorderSide(color: Colors.amber, width: 2.0),
          ),
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Colors.white), // لون النص قبل الكتابة
        ),
      ),
    );

  }
}
