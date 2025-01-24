import 'package:Tourism_app/view/Wedget/IconfavoriteItem.dart';
import 'package:flutter/material.dart';
import '../../model/articalmodel.dart';
import 'CustomDetails.dart';

class CustomCategories extends StatelessWidget {
  final Travel? travel;

  const CustomCategories({super.key, this.travel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (travel != null) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CustomDetails(travel: travel),
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
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned(
                      child: Image(
                        image: AssetImage(
                          travel!.image,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Iconfavoriteitem(
                            travel: travel,
                          )),
                    ), // تمرير travel هنا
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      travel?.name ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Image(
                      image: AssetImage('assets/imagesFood/star.png'),
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      travel!.rating,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  Text(
                    "Egypt ",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Spacer(),
                  Text(
                    '${travel!.price}',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    '/Person',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
