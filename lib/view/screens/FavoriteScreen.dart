import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/itemProvider.dart';
import '../Wedget/CustomDetails.dart';
import '../Wedget/CustomItemScreen.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'My Favorite ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: itemProvider.items.isEmpty
              ? const Center(
                  child: Text('No favorite items',
                      style: TextStyle(fontSize: 18, color: Colors.grey)))
              : ListView.builder(
                  itemCount: itemProvider.items.length,
                  itemBuilder: (context, index) {
                    final travel = itemProvider.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (travel != null) {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            CustomDetails(travel: travel),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          // حركة الصفحة: انزلاق + دوران + تكبير
                                          var slideAnimation = Tween<Offset>(
                                            begin: const Offset(
                                                1.0, 0.5), // يبدأ من الزاوية
                                            end:
                                                Offset.zero, // ينتهي في المنتصف
                                          ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.easeInOutExpo,
                                            ),
                                          );

                                          var rotationAnimation = Tween<double>(
                                                  begin: -0.2, end: 0.0)
                                              .animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.easeOutBack,
                                            ),
                                          );

                                          var scaleAnimation = Tween<double>(
                                                  begin: 0.8, end: 1.0)
                                              .animate(
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
                                                        gradient:
                                                            RadialGradient(
                                                          colors: [
                                                            Colors
                                                                .lightBlueAccent
                                                                .withOpacity(
                                                                    animation
                                                                        .value), // لون أزرق فاتح
                                                            Colors.white
                                                                .withOpacity(1 -
                                                                    animation
                                                                        .value), // خلفية بيضاء
                                                          ],
                                                          radius: 2.5,
                                                          center: Alignment(
                                                              animation.value -
                                                                  0.1,
                                                              animation.value),
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
                                        transitionDuration:
                                            const Duration(milliseconds: 1800),
                                      ),
                                    );
                                  }
                                },
                                child: CustomItemScreen(
                                  travel: travel,
                                  onTap: () {
                                    if (travel != null) {
                                      Provider.of<ItemProvider>(context,
                                              listen: false)
                                          .removeItem(travel);
                                    }
                                  },
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                ),
        );
      },
    );
  }
}
