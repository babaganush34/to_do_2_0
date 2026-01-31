import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_01f/database/app_database.dart';
import '../main.dart';
import '../toDoRepository.dart';
import 'add_cubit.dart';
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

    final repo = TodoRepositoryImpl(AppDatabase());
    final vm = AddViewModel(repo: repo);
    cubit = AddCubit(repo: repo, vm: vm);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(
        repo: repository,
        vm: AddViewModel(repo: repository),
      ),
      child: BlocListener<AddCubit, AddState>(
        listener: (context, state) {
          if (state is AddSuccess) {
            Navigator.pop(context, true);
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Новая задача")),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 142, 142, 142),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hint: Text('введите название задачи'),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Builder(
            builder: (innerContext) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      innerContext.read<AddCubit>().addTodo(title);
                    }
                    setState(() {});
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
                      Icon(Icons.save, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Text(
                        'Сохранить',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
