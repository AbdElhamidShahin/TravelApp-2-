import 'package:Tourism_app/view/Wedget/CustomDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/articalmodel.dart';
import '../../model/itemProvider.dart';
import 'CustomItemScreen.dart';

class Customcutogarisdoun extends StatelessWidget {
  const Customcutogarisdoun({super.key, this.travel});
  final Travel? travel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 8, top: 0),
      child: GestureDetector(
        child: Customitemscreen(
          travel: travel,
          onTap1: () {
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
          onTap: () {
            if (travel != null) {
              Provider.of<ItemProvider>(context, listen: false)
                  .addItem(travel!);
            }
          },
        ),
      ),
    );
  }
}
