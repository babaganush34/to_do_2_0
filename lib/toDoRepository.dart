import 'package:todo_app_01f/database/app_database.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchList();
  Future<int> addTodo({required String title, required String date});
  // Future<Todo> updateTodo(int id, Todo updatedTodo);
}

class TodoRepositoryImpl implements TodoRepository {
  final AppDatabase db;

  TodoRepositoryImpl(this.db);

  @override
  Future<int> addTodo({required String title, required String date}) =>
      db.insertTodo(TodosCompanion.insert(title: title, date: date));

  @override
  Future<List<Todo>> fetchList() => db.getTodoList();

  // @override
  // Future<Todo> updateTodo(int id, Todo updatedTodo) =>
  //     db.updateTodo(id, updatedTodo);
}
