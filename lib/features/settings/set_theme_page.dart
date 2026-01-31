import 'package:flutter/material.dart';
import 'theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetThemePage extends StatelessWidget {
  const SetThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки темы')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    Text(
                      themeMode == ThemeMode.light
                          ? 'Тёмная тема'
                          : 'Светлая тема',
                    ),
                    SizedBox(width: 200),
                    Icon(
                      themeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
