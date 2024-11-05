import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TodoBloc/todo_bloc.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey Margaret",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            Text(
              "Ready to cook something?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 45,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow,
              ),
              child: const Icon(Icons.person_2_rounded),
            ),
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, state) {
        // first state
        if (state is TodoLoadingState || state is TodoInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodoErrorState) {
          return Center(
            child: Column(
              children: [
                Text(state.error.toString()),
                IconButton(
                    onPressed: () =>
                        context.read<TodoBloc>().add(TodoResponseEvent()),
                    icon: const Icon(Icons.refresh))
              ],
            ),
          );
        } else if (state is TodoLoadedState) {
          final todos = state.todos;

          return Stack(
            children: [
              CarouselSlider.builder(
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    final todos = state.todos;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      child: Container(
                        width: 600,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Popular For Dinner",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: Text(
                                      todos[index].title,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.find_replace,
                                            color: Colors.deepOrange,
                                          ),
                                          Text(
                                            "30 Min",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 20),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.find_replace,
                                            color: Colors.deepOrange,
                                          ),
                                          Text(
                                            "30 Min",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Image.network(todos[index].image),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 36 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                          "Meal Category",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.filter,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250, bottom: 460),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                                Icons.fastfood,
                                color: Colors.deepOrange,
                            ),
                            Text(
                                "Salad",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 330),
                child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    children: List.generate(todos.length, (index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 2),
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Image.network(todos[index].image),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                      todos[index].title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      );
                    }),
                ),
              )
            ],
          );
        }
        return Container();
      }),
    );
  }
}

// Text(todos[index].title)