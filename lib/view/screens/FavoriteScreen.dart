import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/itemProvider.dart';
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
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
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
                              Customitemscreen(
                                travel: travel,
                                onTap: () {
                                  if (travel != null) {
                                    Provider.of<ItemProvider>(context,
                                            listen: false)
                                        .removeItem(travel);
                                  }
                                },
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
