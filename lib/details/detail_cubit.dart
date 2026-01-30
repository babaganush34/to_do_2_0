import 'package:todo_app_01f/details/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_01f/details/detail_view_model.dart';
import '../database/app_database.dart';

class DetailCubit extends Cubit<DetailState> {
  final DetailViewModel vm;

  DetailCubit({required this.vm}) : super(DetailInitial());

  Future<void> updateTodo(Todo todo, String title) async {
    if (title.isEmpty) return;

    emit(DetailLoading());
    try {
      await vm.updateTask(todo, title);
      emit(DetailSuccess());
    } catch (e) {
      emit(DetailError(e.toString()));
    }
  }

  Future<void> deleteTodo(int id) async {
    emit(DetailLoading());
    try {
      await vm.deleteTask(id);
      emit(DetailSuccess());
    } catch (e) {
      emit(DetailError(e.toString()));
    }
  }
}
