import 'package:flutter/material.dart';
import '../../model/articalmodel.dart';
import 'IconfavoriteItem.dart';

class CustomDetails extends StatelessWidget {
  final Travel? travel;

  const CustomDetails({
    super.key,
     this.travel,
  });

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
                var sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animation, curve: Curves.easeInOutCubic),
                );

                return SizeTransition(
                  sizeFactor: sizeAnimation,
                  axisAlignment: 0.0,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 600),
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16), top: Radius.circular(16)),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      child: Hero(
                        tag: travel!.image,
                        child: Image.asset(
                          travel!.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(onTap: (){
                        Navigator.pop(context);
                      },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                                child:Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    )),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Iconfavoriteitem(
                              travel: travel,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      travel?.name ?? '',
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Text(
                      "\$225",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Text(
                      "Egypt",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      'Per Person',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                 Divider(
                  color: Colors.grey[300],
                  thickness: 1
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(Icons.location_on_outlined),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      travel?.address ?? '',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(Icons.watch_later_outlined),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      travel?.working_hours ?? '',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    const Image(
                      image: AssetImage('assets/images/star.png'),
                      height: 35,
                      width: 35,
                    ),
                    Text(
                      travel?.rating ?? '',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  travel?.description ?? '',
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(12),
                    ),

                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(

                    child: Text(
                      "Book now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
