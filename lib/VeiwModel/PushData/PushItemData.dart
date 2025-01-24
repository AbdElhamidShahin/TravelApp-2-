import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Tourism_app/model/JsonScrren.dart';
import '../../model/articalmodel.dart';
import '../../view/Wedget/CustomCatogries.dart';

class PushItemData extends StatelessWidget {
  final String category;

  const PushItemData({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Travel>>(
      future: Future.delayed(
        const Duration(seconds: 2),
        () => fetchTravelFromJson(context, category),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // عرض واجهة التحميل أثناء الانتظار
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5, // عدد العناصر الهيكلية
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No travel packages found'));
        }

        final items = snapshot.data!;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.32,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 0, left: 12, right: 12),
                        child: SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              CustomCategories(
                                travel: items[index],
                              ),
                            ],
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
      },
    );
  }
}
