import 'package:todo_app_01f/toDoRepository.dart';
import '../../../database/app_database.dart';

class DetailViewModel {
  final TodoRepository repo;

  DetailViewModel({required this.repo});

  Future<void> updateTask(Todo todo, String newTitle) async {
    final updated = todo.copyWith(title: newTitle);
    await repo.updateTodo(todo.id, updated);
  }

  Future<void> deleteTask(int id) async {
    await repo.deleteTodo(id);
  }
}
