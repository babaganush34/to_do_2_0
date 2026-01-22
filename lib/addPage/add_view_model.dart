import '../toDoRepository.dart';

class AddViewModel {
  final TodoRepository repo;
  AddViewModel({required this.repo});

  Future<void> addTask(String title) async {
    await repo.addTodo(title: title, date: DateTime.now().toString());
  }
}
