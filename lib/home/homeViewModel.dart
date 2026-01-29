import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/toDoRepository.dart';
import 'homeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homeviewmodel {
  final TodoRepository repo;

  Homeviewmodel({required this.repo});

  Future<List<Todo>> loadList() => repo.fetchList();

  Future<int> addTodo({required String title, required String date}) {
    return repo.addTodo(title: title, date: date);
  }
}

class HomeCubit extends Cubit<HomeState> {
  final Homeviewmodel vm;

  HomeCubit({required this.vm}) : super(HomeState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final items = await vm.loadList();
      final filteredItems = filterByDate(items);
      emit(state.copyWith(items: filteredItems, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> toggleTodoFinished(int id, bool isFinished) async {
    try {
      final currentTodo = state.items.firstWhere((item) => item.id == id);
      final updatedTodo = currentTodo.copyWith(isFinished: isFinished);

      // await vm.repo.updateTodo(id, updatedTodo);

      final updatedItems = state.items.map((item) {
        return item.id == id ? updatedTodo : item;
      }).toList();

      emit(state.copyWith(items: updatedItems));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  List<Todo> filterByDate(List<Todo> items) {
    return [...items]..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> addTest(String title) async {
    if (title.isEmpty) return;

    try {
      await vm.addTodo(title: title, date: DateTime.now().toString());
      await init();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
