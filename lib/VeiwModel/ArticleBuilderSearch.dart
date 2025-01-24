import 'package:flutter/material.dart';
import '../model/articalmodel.dart';
import '../view/Wedget/CustomDetails.dart';

class ArticleBuilderSearch extends StatelessWidget {
  final List<Travel> travel; // قائمة الأماكن
  const ArticleBuilderSearch({
    Key? key,
    required this.travel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // عدد الأعمدة
          childAspectRatio: .70,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
        ),
        itemCount: travel.length, // عدد العناصر
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomDetails(travel: travel[index]),
                ),
              );
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
                      child: Image.network(
                        travel[index].image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        travel[index].name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${travel[index].price}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "/Person",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text(
                          travel[index].address ,
                          style:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Spacer(),
                        const Image(
                          image: AssetImage('assets/imagesFood/star.png'),
                          height: 24,
                          width: 24,
                        ),
                        const Text(
                          "4.6",
                          style: TextStyle(color: Colors.black, fontSize: 16),
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
    );
  }
}
