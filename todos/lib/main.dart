import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/sharedState.dart';
import 'package:todos/task.dart';
import 'package:todos/todo.dart';

Future<List<Task>>
GetTodos() async {
    var a =  await http.get(Uri.parse('http://10.0.2.2:8000/todos'));
    Map<String, dynamic> b = jsonDecode(a.body);
    List<Task> result = b.keys.map<Task>((key) {
      return Task(title: b[key]['title'], isCompleted: b[key]['isCompleted']);
    }).toList();
    return result;
}

Future<void> main() async {
  final tasks = await GetTodos();

  runApp(
    SharedState(
      tasks: tasks,
      color: Colors.green,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() =>
      _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final tasks = SharedState.of(
      context,
    ).tasks;

    print("AAA ${tasks.length}");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor:
              Colors.limeAccent,
          centerTitle: true,
        ),
        body: ListView.builder(
          key: const Key('long_list'),
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder:
              (context, index) {
                return Todo(
                  task: tasks[index],
                );
              },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
