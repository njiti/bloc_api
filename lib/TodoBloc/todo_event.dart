part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class TodoResponseEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}