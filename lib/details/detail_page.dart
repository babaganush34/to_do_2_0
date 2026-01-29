import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_01f/main.dart';
import '../database/app_database.dart';

class DetailPage extends StatefulWidget {
  final Todo todo;

  const DetailPage({super.key, required this.todo});

  @override
  State<StatefulWidget> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  late final TextEditingController _controller;
  late final String newTitle;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.todo.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Детали')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Flex(
          direction: Axis.vertical,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Название',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
              onPressed: () async {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  await database.updateTodo(
                    widget.todo.id,
                    TodosCompanion(title: Value(text)),
                  );
                  if (mounted) {
                    Navigator.pop(context, true);
                    setState(() {});
                  }
                  setState(() {});
                }
              },
              child: const Text("Сохранить"),
            ),
            TextButton(onPressed: () => (), child: Text("Удалить")),
          ],
        ),
      ),
    );
  }
}
