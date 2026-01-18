import 'package:flutter_bloc/flutter_bloc.dart';
import '../toDoRepository.dart';
import 'add_state.dart';

class AddViewModel {
  final TodoRepository repo;
  AddViewModel({required this.repo});

  Future<void> addTask(String title) async {
    await repo.addTodo(title: title, date: DateTime.now().toString());
  }
}

class AddCubit extends Cubit<AddState> {
  final TodoRepository repo;

  AddCubit({required this.repo, required AddViewModel vm}) : super(AddInitial());

  Future<void> saveTask(String title) async {
    if (title.isEmpty) return;
    emit(AddLoading());
    await repo.addTodo(title: title, date: DateTime.now().toString());
    emit(AddSuccess());
  }
}