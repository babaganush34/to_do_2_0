import 'package:todo_app_01f/toDoRepository.dart';
import '../toDo.dart';
import 'homeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homeviewmodel {
  final TodoRepository repo;

  Homeviewmodel({required this.repo});

  Future <List<ToDo>> loadList() => repo.fetchList();
}

class HomeCubit extends Cubit<HomeState> {
  final Homeviewmodel vm;

  HomeCubit({required this.vm}) : super(HomeState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final items = await vm.loadList();
      final filteredItems = filterByDate(items);
      emit(state.copyWith(items: items, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> toggleTodoFinished(int id, bool isFinished) async {
    try {
      final currentTodo = state.items.firstWhere((item) => item.id == id);
      final updatedTodo = currentTodo.copyWith(isFinished: isFinished);
      
      await vm.repo.updateTodo(id, updatedTodo);
      
      final updatedItems = state.items.map((item) {
        return item.id == id ? updatedTodo : item;
      }).toList();
      
      emit(state.copyWith(items: updatedItems));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
  List<ToDo> filterByDate(List<ToDo> items) {
    return [...items]..sort((a, b) => b.date.compareTo(a.date));
  }
}