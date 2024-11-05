part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoErrorState extends TodoState {
  final String error;
  const TodoErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class TodoLoadedState extends TodoState {
  final List<Result> todos;
  const TodoLoadedState(this.todos);
  @override
  List<Object> get props => [todos];
}