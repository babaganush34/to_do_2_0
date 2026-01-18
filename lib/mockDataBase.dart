import 'package:todo_app_01f/toDo.dart';

class MockDataBase {
  static final List<ToDo> _items = [];

  int _nextId = 2;

  Future<ToDo> add(String title, String date) async {
    final todo = ToDo(
      id: _nextId++,
      title: title,
      isFinished: false,
      date: date,
    );
    _items.add(todo);
    return todo;
  }

  Future<List<ToDo>> getList() async {
    return List.from(_items);
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
