import 'package:todo_app_01f/toDo.dart';

class MockDataBase {
  final List<ToDo> _items = [
    ToDo(
      id: 1,
      title: "Купить продукты",
      isFinished: false,
      date: DateTime.now().toString(),
    ),
    ToDo(
      id: 2,
      title: "Прочитать книгу",
      isFinished: false,
      date: DateTime.now().toString(),
    ),
    ToDo(
      id: 3,
      title: "Пойти на тренировку",
      isFinished: false,
      date: DateTime.now().toString(),
    ),
  ];

  int _nextId = 4;

  Future<ToDo> add(String title, String date) async {
    final todo = ToDo(
      id: _nextId++,
      title: title,
      isFinished: false,
      date: date,
    );
    return todo;
  }

  Future<List<ToDo>> getList() async {
    return List.unmodifiable(_items);
  }

  Future<ToDo> updateTodo(int id, ToDo updatedTodo) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] = updatedTodo;
      return updatedTodo;
    }
    throw Exception('Todo not found');
  }
}
