import 'mockDataBase.dart';
import 'toDo.dart';

abstract class TodoRepository {
  Future<List<ToDo>> fetchList();
  Future<ToDo> addTodo({required String title, required String date});
  Future<ToDo> updateTodo(int id, ToDo updatedTodo);
}

class TodoRepositoryImpl implements TodoRepository {
  final MockDataBase db;

  TodoRepositoryImpl(this.db);

  @override
  Future<ToDo> addTodo({required String title, required String date}) => db.add(title, date);

  @override
  Future<List<ToDo>> fetchList() => db.getList();

  @override
  Future<ToDo> updateTodo(int id, ToDo updatedTodo) => db.updateTodo(id, updatedTodo);
}