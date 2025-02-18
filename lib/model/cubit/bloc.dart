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

  bool isDark = false;

  void toggleTheme() {
    print("Toggle theme called"); // للتأكد من استدعاء الدالة
    if (state is ThemeState) {
      final currentTheme = (state as ThemeState).themeMode;
      final newTheme = currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      print("Changing theme to: $newTheme"); // لتتبع التبديل
      emit(ThemeState(newTheme)); // إطلاق الحالة الجديدة
    }
  }

  }



