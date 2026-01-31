import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/services/app_preferences.dart';
import 'package:todo_app_01f/toDoRepository.dart';
import 'features/home_page/home/homePage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/settings/theme_cubit.dart';

late final AppDatabase database;
late final TodoRepository repository;
late final AppPreferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();
  repository = TodoRepositoryImpl(database);
  preferences = AppPreferences.instance;
  await preferences.init();

  runApp(BlocProvider(create: (_) => ThemeCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
          ),
          home: const MyHomePage(title: 'Мои задачи'),
        );
      },
    );
  }
}
