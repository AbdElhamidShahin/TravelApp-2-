import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'articalmodel.dart';
Future<List<Travel>> fetchTravelFromJson(BuildContext context, String category) async {
  try {
    final String response = await rootBundle.loadString('assets/Travel.json');
    final Map<String, dynamic> data = json.decode(response);

    if (data.containsKey(category)) {
      final List<dynamic> categoryData = data[category] as List<dynamic>;
      List<Travel> travels = categoryData.map((json) => Travel.fromJson(json)).toList();
      return travels;
    } else {
      debugPrint('الفئة "$category" غير موجودة في البيانات.');
      return [];
    }
  } catch (e) {
    debugPrint('خطأ أثناء تحميل البيانات: $e');
    return [];
  }}