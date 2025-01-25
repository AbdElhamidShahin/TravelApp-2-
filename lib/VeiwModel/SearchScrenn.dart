import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/articalmodel.dart';
import '../view/Wedget/CustomDetails.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> results = [];
  String query = "";

  void search(String query) async {
    var resultsList = await ExerciseService.searchExercises(query);
    setState(() {
      results = resultsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    query = text;
                  });
                  search(query);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Discover your place',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .90,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final item = results[index];

                  return GestureDetector(
                    onTap: () {
                      final travelItem = Travel.fromJson(item);

                      if (travelItem != null) {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                CustomDetails(travel: travelItem),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              // حركة الصفحة: انزلاق + دوران + تكبير
                              var slideAnimation = Tween<Offset>(
                                begin: const Offset(1.0, 0.5), // يبدأ من الزاوية
                                end: Offset.zero, // ينتهي في المنتصف
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOutExpo,
                                ),
                              );

                              var rotationAnimation =
                              Tween<double>(begin: -0.2, end: 0.0).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutBack,
                                ),
                              );

                              var scaleAnimation =
                              Tween<double>(begin: 0.8, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.fastOutSlowIn,
                                ),
                              );

                              // خلفية متحركة بألوان حيادية
                              return Stack(
                                children: [
                                  Positioned.fill(
                                    child: AnimatedBuilder(
                                      animation: animation,
                                      builder: (context, _) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            gradient: RadialGradient(
                                              colors: [
                                                Colors.lightBlueAccent.withOpacity(
                                                    animation.value), // لون أزرق فاتح
                                                Colors.white.withOpacity(
                                                    1 - animation.value), // خلفية بيضاء
                                              ],
                                              radius: 2.5,
                                              center: Alignment(
                                                  animation.value - 0.1, animation.value),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // تأثير Lottie مع الحركة
                                  SlideTransition(
                                    position: slideAnimation,
                                    child: RotationTransition(
                                      turns: rotationAnimation,
                                      child: ScaleTransition(
                                        scale: scaleAnimation,
                                        child: child,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 1800),
                          ),
                        );
                      }
                    },


                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                item['image'] ??
                                    '', // Default empty string if image is null
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image,
                                        color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                item['name'] ??
                                    'No Name', // Default text if 'name' is null
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  item['price'] ??
                                      'Price Not Available', // Default text if 'price' is null
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  "/Person",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const Spacer(),
                                const Image(
                                  image: AssetImage('assets/images/star.png'),
                                  height: 24,
                                  width: 24,
                                ),
                                const Text(
                                  "4.6",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseService {
  static Future<List<Map<String, dynamic>>> searchExercises(
      String query) async {
    final String response = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    final Map<String, dynamic> categories = jsonData['categories'] ?? {};

    final dynamic egyptianLandmarks = categories['egyptian_landmarks'];
    final dynamic naturalPlaces = categories['natural_places'];
    final dynamic egyptian_cities = categories['egyptian_cities'];
    final dynamic tour_packages = categories['tour_packages'];
    final dynamic egyptian_hills = categories['egyptian_hills'];

    final List<dynamic> combinedList = [
      ...?egyptianLandmarks,
      ...?naturalPlaces,
      ...?egyptian_cities,
      ...?tour_packages,
      ...?egyptian_hills,
    ];

    return combinedList
        .where((item) =>
            item is Map<String, dynamic> &&
            item['name'] != null &&
            item['name'].toLowerCase().contains(query.toLowerCase()))
        .cast<Map<String, dynamic>>()
        .toList();
  }
}
