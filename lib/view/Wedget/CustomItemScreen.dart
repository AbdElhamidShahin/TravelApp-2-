import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../model/articalmodel.dart';

class CustomItemScreen extends StatefulWidget {
  const CustomItemScreen({
    super.key,
    this.travel,
    this.onTap,
    this.onTap1,
  });

  final Travel? travel;
  final VoidCallback? onTap;
  final VoidCallback? onTap1;

  @override
  State<CustomItemScreen> createState() => _CustomItemScreenState();
}

class _CustomItemScreenState extends State<CustomItemScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Stack(
                children: [
                  // Check if travel object is null before accessing image
                  widget.travel?.image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage(widget.travel!.image),
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const SizedBox.shrink(), // Handle null image
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        if (widget.onTap != null) {
                          widget.onTap!();
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 24,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: AutoSizeText(
                            widget.travel?.name ?? 'Unknown',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            minFontSize: 12,
                            stepGranularity: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          "Starting from ",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          widget.travel?.price != null
                              ? "${widget.travel!.price}\$"
                              : "N/A",
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const Text(
                          'Egypt',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(width: 30),
                        Image.asset(
                          'assets/images/star.png',
                          height: 24,
                          width: 24,
                        ),
                        Text(
                          widget.travel?.rating ?? '0',
                          style: const TextStyle(color: Colors.black, fontSize: 16),
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
