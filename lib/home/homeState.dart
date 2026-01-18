import '../toDo.dart';

class HomeState {
  final List<ToDo> items;
  final bool isLoading;
  final String? error;

  const HomeState({
    required this.items,
    required this.isLoading,
    required this.error,
  });

  factory HomeState.initial() => HomeState(
    items: [], 
    isLoading: false, 
    error: null
    );

    HomeState copyWith({
      List<ToDo>? items,
      bool? isLoading,
      String? error,
    }) {
      return HomeState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
    }
}
