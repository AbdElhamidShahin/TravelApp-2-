import 'package:Tourism_app/VeiwModel/helper/thems.dart';
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
    return  BlocBuilder<TravelCubit, TravelState>(
      builder: (context, state) {
        // تأكد من أنه يتم التحقق من حالة ThemeState بشكل صحيح
        if (state is ThemeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.themeMode == ThemeMode.light ? ThemeData.light() : ThemeData.dark(),
            darkTheme: state.themeMode == ThemeMode.light ? ThemeData.dark() : ThemeData.light(),
            home: HomePage(),
          );

        }

        // في حال لم تكن الحالة ThemeState
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.light(),
          home: HomePage(),
        );
      },
    );
  }
}