import 'dart:convert';

import 'package:Tourism_app/model/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view/screens/tabpar.dart';
import '../../view/screens/SettingScreen.dart';
import '../../view/screens/FavoriteScreen.dart';
import '../articalmodel.dart';

class TravelCubit extends Cubit<TravelState> {
  TravelCubit() : super((TravelInitialState()));

  static TravelCubit get(context) => BlocProvider.of<TravelCubit>(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline_rounded),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_outlined),
    ),
  ];

  List<Widget> screens = [
    TabBarPage(),
    Favorite(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {}
    emit(TravelBottomnavBarState());
  }

  List<Travel> naturalPlaces = [];
  List<Travel> searchResults = [];

  Future<void> loadData() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/json/travel.json');
      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.containsKey('natural_places')) {
        List<dynamic> placesJson = jsonResponse['natural_places'];
        naturalPlaces =
            placesJson.map((data) => Travel.fromJson(data)).toList();
        emit(TravelInitialState());
      } else {
        throw Exception('Key "natural_places" not found in JSON');
      }
    } catch (e) {
      print('Error loading JSON data: $e');
      emit(TravelErrorState(error: 'Error loading data'));
    }
  }
  void getSearch(String value) {
    emit(TravelGetSearchLodingState());

    if (value.trim().isEmpty) {
      searchResults = [];
      emit(TravelGetSearchEmptyState());
      return;
    }

    try {
      searchResults = naturalPlaces.where((place) {
        if (place.name == null) return false; // تجاهل العناصر غير الصالحة
        final name = place.name.toLowerCase();
        final searchValue = value.toLowerCase();

        print('Searching for: $searchValue in $name');
        return name.contains(searchValue);
      }).toList();

      if (searchResults.isEmpty) {
        print('No matches found for: $value');
        emit(TravelGetSearchEmptyState());
      } else {
        emit(TravelGetSearchSuccessState());
      }
    } catch (error) {
      print('Error during search: $error');
      emit(TravelGetDataErrorState(error.toString()));
    }
  }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    print("Mode changed: $isDark");
    emit(AppChangeModeState(isDark));
  }

}
