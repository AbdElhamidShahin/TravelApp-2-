import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../model/articalmodel.dart';

class Customitemscreen extends StatefulWidget {
  const Customitemscreen({
    super.key,
    this.travel,
    this.onTap,
    this.onTap1,
  });
  final Travel? travel;
  final VoidCallback? onTap;
  final VoidCallback? onTap1;

  @override
  State<Customitemscreen> createState() => _CustomitemscreenState();
}

class _CustomitemscreenState extends State<Customitemscreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap1, // استخدم widget.onTap هنا
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage(
                        widget.travel!.image,
                      ),
                      width: MediaQuery.of(context).size.width * 0.42,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        if (widget.onTap != null) {
                          widget.onTap!();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.favorite_outlined,
                          size: 30,
                          color: isFavorite ? Colors.red : Colors.transparent,
                          shadows: [
                            const BoxShadow(
                              color: Colors.white,
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.travel?.name ?? 'No Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22, // الحجم الأساسي للنص
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1, // النص سيكون في سطر واحد فقط
                      minFontSize: 12, // الحجم الأدنى للنص عند الحاجة
                      stepGranularity: 3, // تغيير الحجم بشكل تدريجي
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Starting from ",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          "${widget.travel!.price}\$",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text(
                          'Egypt',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(width: 30),
                        Image(
                          image: AssetImage('assets/imagesFood/star.png'),
                          height: 24,
                          width: 24,
                        ),
                        Text(
                          widget.travel!.rating,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
