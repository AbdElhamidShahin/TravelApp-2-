import 'package:flutter/material.dart';
import 'package:Tourism_app/view/Wedget/CustomCutogarisDoun.dart';
import '../../model/JsonScrren.dart';
import '../../model/articalmodel.dart';
import '../Wedget/UpperHomepageUi.dart'; // Ensure correct path for UpperHomepageUi.dart
import '../Wedget/CustomTabbar.dart'; // Ensure correct path for CustomTabbar.dart
import 'package:shimmer/shimmer.dart'; // لإضافة تأثير التحميل

class TabBarPage extends StatefulWidget {
  final String? category;

  const TabBarPage({super.key, this.category});

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Upperhomepageui(), // Upper homepage UI
          const SizedBox(height: 16),
          const Customtabbar(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Tour Packages",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            ),
          ),
          Expanded(
            // Wrap the main content with Expanded to avoid overflow
            child: SingleChildScrollView(
              child: FutureBuilder<List<Travel>>(
                future: Future.delayed(
                  const Duration(seconds: 2),
                  () => fetchTravelFromJson(
                      context, widget.category ?? "tour_packages"),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 160, // تخصيص الحجم
                              margin: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No travel packages found'));
                  }

                  final items = snapshot.data!;

                  return Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Customcutogarisdoun(
                            travel: items[index],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
