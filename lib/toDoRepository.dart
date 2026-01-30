import 'package:todo_app_01f/database/app_database.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchList();
  Future<int> addTodo({required String title, required String date});
  Future<int> updateTodo(int id, Todo updatedTodo);
  Future<int> deleteTodo(int id);
}

class TodoRepositoryImpl implements TodoRepository {
  final AppDatabase db;

  TodoRepositoryImpl(this.db);

  @override
  Future<int> addTodo({required String title, required String date}) =>
      db.insertTodo(TodosCompanion.insert(title: title, date: date));

  @override
  Future<List<Todo>> fetchList() => db.getTodoList();

  @override
  Future<int> updateTodo(int id, Todo updatedTodo) async {
    final companion = updatedTodo.toCompanion(true);
    return await db.updateTodo(id, companion);
  }

  @override
  Future<int> deleteTodo(int id) {
    return db.deleteTodo(id);
  }
}
