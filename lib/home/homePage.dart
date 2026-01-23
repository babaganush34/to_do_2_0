import 'package:flutter/material.dart';
import 'package:todo_app_01f/home/homeViewModel.dart';
import 'package:todo_app_01f/mockDataBase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../addPage/addPage.dart';
import '../settings/set_theme_page.dart';
import '../toDoRepository.dart';
import 'homeState.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeCubit cubit;
  ThemeMode themeMode = ThemeMode.light;
  void onToggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void initState() {
    final db = MockDataBase();
    final repo = TodoRepositoryImpl(db);
    final vm = Homeviewmodel(repo: repo);
    cubit = HomeCubit(vm: vm)..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          shape: Border(bottom: BorderSide(color: Colors.black)),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SetThemePage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              print(state.isLoading.toString());
            }
            if (state.error != null) {
              print(state.error.toString());
            }
            if (state.items.isEmpty) {
              return Text('Список пуст');
            }
            return ListView.builder(
              padding: EdgeInsets.only(left: 5, right: 5, top: 50),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final todo = state.items[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        color: Colors.white,
                        todo.isFinished
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      onPressed: () {
                        cubit.toggleTodoFinished(todo.id, !todo.isFinished);
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      todo.date,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.end,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tileColor: const Color(0xFF4285F4),
                  ),
                );
              },
            );
          },
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                final bool? needUpdate = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPage()),
                );
                if (needUpdate == true) {
                  cubit.init();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Добавить задачу',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
