import 'package:Tourism_app/model/cubit/states.dart';
import 'package:Tourism_app/view/Login/LoginScreen.dart';
import 'package:Tourism_app/view/screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model/cubit/bloc.dart';
import 'model/itemProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TravelCubit>(
          create: (context) => TravelCubit(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ItemProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=> TravelCubit()..changeAppMode(),
      child: BlocConsumer<TravelCubit, TravelState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFF5F5F5),
              appBarTheme: const AppBarTheme(
                color: Color(0xFFF5F5F5),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  fontFamily: 'FontFamily1',
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textTheme: const TextTheme(
                headlineLarge: TextStyle(
                  color: Colors.black,
                  fontFamily: 'FontFamily1',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                bodyLarge: TextStyle(
                  color: Colors.black,
                  fontFamily: 'FontFamily2',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                bodyMedium: TextStyle(
                  color: Colors.black,
                  fontFamily: 'FontFamily3',
                  fontSize: 16,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // Text color for text buttons
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black, // Background color for elevated buttons
                ),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF1E201E),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E201E),
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                bodyMedium: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                headlineLarge: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),bodySmall: TextStyle(
                color: Colors.white
              ),titleSmall: TextStyle(
                  color: Colors.white
              ),titleMedium: TextStyle(
                  color: Colors.white
              ),titleLarge: TextStyle(
                  color: Colors.white
              ),labelSmall: TextStyle(
                  color: Colors.white
              ),headlineSmall: TextStyle(
                  color: Colors.white
              ),labelMedium: TextStyle(
                  color: Colors.white
              ),

                displayLarge: TextStyle(
                    color: Colors.white
                ),displayMedium: TextStyle(
                  color: Colors.white
              ),displaySmall: TextStyle(
                  color: Colors.white
              ),labelLarge: TextStyle(
                  color: Colors.white
              ),headlineMedium: TextStyle(
                  color: Colors.white
              ),

              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // Text color for text buttons
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
              useMaterial3: true,
            ),
            themeMode: TravelCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: HomePage(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
