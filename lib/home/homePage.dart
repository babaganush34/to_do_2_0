import 'package:flutter/material.dart';
import 'package:todo_app_01f/home/homeViewModel.dart';
import 'package:todo_app_01f/mockDataBase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../addPage/addPage.dart';
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
        appBar: AppBar(title: Text(widget.title)),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              print("Показываете лоудер");
            }
            if (state.error != null) {
              print(state.error.toString());
            }
            if (state.items.isEmpty) {
              return Text('Список пуст');
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final todo = state.items[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.date),
                  trailing: IconButton(
                    icon: Icon(
                      todo.isFinished
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    onPressed: () {
                      cubit.toggleTodoFinished(todo.id, !todo.isFinished);
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final bool? needUpdate = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPage()),
            );
            if (needUpdate == true) {
              cubit.init();
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
