import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/toDoRepository.dart';


class Homeviewmodel {
  final TodoRepository repo;

  Homeviewmodel({required this.repo});

  Future<List<Todo>> loadList() => repo.fetchList();

  Future<int> addTodo({required String title, required String date}) {
    return repo.addTodo(title: title, date: date);
  }
}

