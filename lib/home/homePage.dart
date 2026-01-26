import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/main.dart';
import 'package:drift/drift.dart' show Value;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _toggleTodo(Todo todo) async {
    await (database.update(database.todos)..where((t) => t.id.equals(todo.id)))
        .write(TodosCompanion(isFinished: Value(!todo.isFinished)));
    setState(() {});
  }

  Future<void> _deleteTodo(Todo todo) async {
    await (database.delete(
      database.todos,
    )..where((t) => t.id.equals(todo.id))).go();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Todo>>(
        future: database.getTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Ошибка: ${snapshot.error}"));
          }

          final todoList = snapshot.data ?? [];

          if (todoList.isEmpty) {
            return const Center(child: Text("Список пуст"));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              top: 20,
              bottom: 100,
            ),
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final item = todoList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(
                      item.isFinished
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.white,
                    ),
                    onPressed: () => _toggleTodo(item),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    item.date,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.end,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: item.isFinished
                      ? Colors.grey
                      : const Color(0xFF4285F4),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTodo(item), 
                        ),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: _buildAddButton(),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () async {
            await database.insertTodo(
              TodosCompanion.insert(
                title: "Новая задача ${DateTime.now().second}",
                date: DateTime.now().toString().substring(0, 16),
              ),
            );
            setState(() {});
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4285F4),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
    );
  }
}
