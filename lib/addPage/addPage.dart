import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../mockDataBase.dart';
import '../toDoRepository.dart';
import 'add_view_model.dart';
import 'add_state.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late TextEditingController titleController;
  late AddCubit cubit;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();

    final repo = TodoRepositoryImpl(MockDataBase());
    final vm = AddViewModel(repo: repo);
    cubit = AddCubit(repo: repo, vm: vm);
  }

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) {
      final repo = TodoRepositoryImpl(MockDataBase());
      final vm = AddViewModel(repo: repo);
      return AddCubit(repo: repo, vm: vm);
    },
    child: BlocListener<AddCubit, AddState>(
      listener: (context, state) {
        if (state is AddSuccess) {
          Navigator.pop(context, true); 
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Новая задача")),
        body: Column(
          children: [
            TextField(controller: titleController),
            Builder(
              builder: (innerContext) {
                return ElevatedButton(
                  onPressed: () {
                    innerContext.read<AddCubit>().saveTask(titleController.text);
                  },
                  child: const Text("Сохранить"),
                );
              }
            ),
          ],
        ),
      ),
    ),
  );
}
}
