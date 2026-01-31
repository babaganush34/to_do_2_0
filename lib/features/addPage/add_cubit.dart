import 'package:flutter_bloc/flutter_bloc.dart';
import '../toDoRepository.dart';
import 'add_state.dart';
import 'add_view_model.dart';

class AddCubit extends Cubit<AddState> {
  final TodoRepository repo;
  AddCubit({required this.repo, required AddViewModel vm})
    : super(AddInitial());

  Future<void> addTodo(String title) async {
    if (title.isEmpty) return;

    emit(AddLoading());
    try {
      await repo.addTodo(
        title: title,
        date: DateTime.now().toString().substring(0, 16),
      );
      emit(AddSuccess());
    } catch (e) {
      emit(AddError(e.toString()));
    }
  }
}
