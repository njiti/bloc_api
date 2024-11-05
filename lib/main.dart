import 'package:bloc_api/Repository/repository.dart';
import 'package:bloc_api/TodoBloc/todo_bloc.dart';
import 'package:bloc_api/TodoView/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // When we run the app - on the start loads the todos
    return BlocProvider(
      create: (context) => TodoBloc(Repository())..add(TodoResponseEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoView(),
      ),
    );
  }
}