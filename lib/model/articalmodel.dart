import 'dart:convert';

import 'package:flutter/services.dart';

class Travel {
  final String name;
  final String description;
  final String image;
  final String address;
  final String rating;
  final String working_hours;
  final String price;

  bool isFavorite;

  Travel({
    required this.name,
    required this.description,
    required this.isFavorite,
    required this.image,
    required this.address,
    required this.working_hours,
    required this.price,
    required this.rating,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      name: json['name'] as String? ?? 'وصفة غير معروفة',
      description: json['description'] as String? ?? 'لا تتوفر وصفة.',
      image: json['image'] as String? ?? 'assets/images/default.png',
      address: json['address'] as String? ?? 'وصفة غير معروفة',
      working_hours: json['working_hours'] as String? ?? 'لا تتوفر وصفة.',
      price: json['price'] as String? ?? 'assets/images/default.png',
      rating: json["rating"] as String? ?? "rating",
      isFavorite: json['isFavorite'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'address': address,
      'working_hours': working_hours,
      'price': price,
      'rating': rating,
    };
  }
}

// دالة لتحميل البيانات من JSON
Future<List<Travel>> fetchRecipes() async {
  final String response =
      await rootBundle.loadString('assets/Travel.json');
  final data = json.decode(response) as List<dynamic>;

  return data.map((json) => Travel.fromJson(json)).toList();
}
