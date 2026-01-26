import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_01f/database/app_database.dart';
import '../main.dart';
import '../mockDataBase.dart';
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
          appBar: AppBar(
            title: const Text("Новая задача"),
            shape: Border(bottom: BorderSide(color: Colors.black)),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 50),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 205, 205, 205),
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.text.trim();
                      if (title.isNotEmpty) {
                        await database.insertTodo(
                          TodosCompanion.insert(
                            title: title,
                            date: DateTime.now().toString().substring(0, 16),
                          ),
                        );
                        if (context.mounted) {
                          Navigator.pop(context, true);
                        }
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
