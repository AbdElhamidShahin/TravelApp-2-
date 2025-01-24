import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/cubit/bloc.dart';
import '../model/cubit/states.dart';
import 'ArticleBuilderSearch.dart';

class Search extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              onChanged: (value) {
                if (value.trim().isNotEmpty) {
                  TravelCubit.get(context).getSearch(value);
                }
              },
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
          ),
          Flexible(
            child: BlocConsumer<TravelCubit, TravelState>(
              listener: (BuildContext context, TravelState state) {
                if (state is TravelErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.error}'),
                    ),
                  );
                }
              },
              builder: (BuildContext context, TravelState state) {
                var list = TravelCubit.get(context).searchResults;

                if (state is TravelGetSearchLodingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (list.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        "No results found. Try another search.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  );
                }

                return ArticleBuilderSearch(travel: list);
              },
            ),
          ),
        ],
      ),
    );
  }
}
