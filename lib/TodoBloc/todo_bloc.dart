import 'package:bloc/bloc.dart';
import 'package:bloc_api/Repository/repository.dart';
import 'package:equatable/equatable.dart';

import '../Model/todos.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Repository _repository;
  TodoBloc(this._repository) : super(TodoInitial()) {

    // Response event
    on<TodoResponseEvent>((event, emit) async{
      emit(TodoLoadingState());
      await _repository.get().then((value) =>
      emit(TodoLoadedState(value))).catchError((e)=>
          emit(TodoErrorState(e.toString())));
    });
  }
}
