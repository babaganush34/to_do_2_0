import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/details/detail_cubit.dart';
import 'package:todo_app_01f/details/detail_view_model.dart';
import 'package:todo_app_01f/main.dart'; // чтобы видеть глобальный repository
import 'detail_state.dart';

class DetailPage extends StatefulWidget {
  final Todo todo;

  const DetailPage({super.key, required this.todo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Сразу подставляем текущее название задачи в поле ввода
    _controller = TextEditingController(text: widget.todo.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Создаем кубит и передаем ему VM с репозиторием
      create: (context) => DetailCubit(vm: DetailViewModel(repo: repository)),
      // Используем Builder, чтобы создать новый контекст ВНУТРИ провайдера
      child: Builder(
        builder: (context) {
          return BlocListener<DetailCubit, DetailState>(
            listener: (context, state) {
              if (state is DetailSuccess) {
                // Возвращаемся на главный экран с пометкой "true" (нужно обновить список)
                Navigator.pop(context, true);
              }
              if (state is DetailError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Детали'),
                actions: [
                  IconButton(
                    onPressed: () {
                      // Теперь этот context видит DetailCubit
                      context.read<DetailCubit>().deleteTodo(widget.todo.id);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
              body: BlocBuilder<DetailCubit, DetailState>(
                builder: (context, state) {
                  // Если идет сохранение или удаление — показываем загрузку
                  if (state is DetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 230, 230, 230),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            hintText: 'Введите название задачи',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              bottomSheet: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      final title = _controller.text.trim();
                      if (title.isNotEmpty) {
                        // Вызываем обновление
                        context.read<DetailCubit>().updateTodo(
                          widget.todo,
                          title,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4285F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          'Сохранить изменения',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
