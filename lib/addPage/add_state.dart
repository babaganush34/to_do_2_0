abstract class AddState {}

class AddInitial extends AddState {}

class AddLoading extends AddState {}

class AddSuccess extends AddState {}

class AddError extends AddState {
  final String message;
  AddError(this.message);
}
