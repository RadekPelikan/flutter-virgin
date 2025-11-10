import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/sharedState.dart';
import 'package:todos/task.dart';
import 'package:todos/todo.dart';

Future<List<Task>> GetTodos() async {
  var a = await http.get(
    Uri.parse(
      'http://10.0.2.2:8000/todos',
    ),
  );
  Map<String, dynamic> b = jsonDecode(
    a.body,
  );
  List<Task> result = b.keys.map<Task>((
    key,
  ) {
    return Task(
      title: b[key]['title'],
      isCompleted:
          b[key]['isCompleted'],
    );
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
  late TextEditingController
  _controller;

  Color? color;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleChange(String string) {
    var text = string;

    setState(() {
      if (text.isEmpty) {
        color = Colors.grey;
      } else {
        color = Colors.black;
      }
    });
  }

  void handlePost() async {
    var text = _controller.text;

    if (text.isEmpty) {
      return;
    }

    var a = await http.post(
      Uri.parse(
        'http://10.0.2.2:8000/todos?title=${text}',
      ),
    );
    Map<String, dynamic> b = jsonDecode(
      a.body,
    );
    List<Task> result = b.keys
        .map<Task>((key) {
          return Task(
            title: b[key]['title'],
            isCompleted:
                b[key]['isCompleted'],
          );
        })
        .toList();

    _controller.text = "";
    setState(() {
      SharedState.of(context).tasks
        ..clear()
        ..addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = SharedState.of(
      context,
    ).tasks;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor:
              Colors.limeAccent,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged:
                        handleChange,
                    controller:
                        _controller,
                    decoration: InputDecoration(
                      border:
                          OutlineInputBorder(),
                      hintText:
                          'Enter a search term',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: handlePost,
                  icon: Icon(
                    Icons.send,
                    color: color,
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                key: const Key(
                  'long_list',
                ),
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder:
                    (context, index) {
                      return Todo(
                        task:
                            tasks[index],
                      );
                    },
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
