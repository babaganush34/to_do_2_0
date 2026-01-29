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
      appBar: AppBar(
        title: Text('Детали'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Flex(
          direction: Axis.vertical,
          children: [
            TextField(
              controller: _controller,
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
            SizedBox(height: 600),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
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
              child: const Text(
                "Сохранить",
                style: TextStyle(color: Colors.white),
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
    );
  }
}
