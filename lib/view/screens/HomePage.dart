import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/cubit/bloc.dart';
import '../../model/cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TravelCubit(),
      child: BlocConsumer<TravelCubit,TravelState>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          var cubit = TravelCubit.get(context);

          return Scaffold(
            body: cubit.screens[cubit.currentIndex],  // يعرض الشاشة بناءً على الفهرس الحالي
            bottomNavigationBar: Container(
              height: 70,
              margin: const EdgeInsets.all(0),  // إضافة مسافة حول الشريط السفلي
              decoration: BoxDecoration(
                color: Colors.black54,  // لون خلفية الشريط
                borderRadius: BorderRadius.circular(30),  // جعل الزوايا مستديرة
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(32),topLeft: Radius.circular(32)),  // قص الحواف لتصبح دائرية
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: cubit.currentIndex == 0 ? Colors.black : Colors.transparent, // الخلفية السوداء للعنصر النشط فقط
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.home,size: 30,), // الأيقونة
                      ),
                      label: '', // إزالة التسمية
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: cubit.currentIndex == 1 ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.favorite_outline,size: 30,),
                      ),
                      label: '', // إزالة التسمية
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: cubit.currentIndex == 2 ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.person,size: 30,),
                      ),
                      label: '', // إزالة التسمية
                    ),
                  ],
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottomNavBar(index); // تغيير الفهرس عند الضغط
                  },
                  type: BottomNavigationBarType.fixed, // نوع الشريط
                  selectedItemColor: Colors.white, // لون العنصر النشط
                  unselectedItemColor: Colors.black, // لون العناصر غير النشطة
                  backgroundColor: Colors.white, // لون الخلفية
                  elevation: 0,  selectedLabelStyle: TextStyle(
                  fontSize: 1.0, // حجم النص النشط
                  fontWeight: FontWeight.bold,
                ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 1.0, // حجم النص غير النشط
                    fontWeight: FontWeight.normal,
                  ), // إزالة الظل
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}
