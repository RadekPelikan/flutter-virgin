import 'package:flutter/material.dart';
import 'package:todos/task.dart';

class Todo extends StatefulWidget {
  const Todo({
    super.key,
    required this.task
  });

  final Task task;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {

  void checkboxOnClick(bool? value, Task task) {
    task.isCompleted = value!;
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: widget.task.isCompleted, onChanged: (value) {
          setState(() {
            checkboxOnClick(value, widget.task);
          });
        },),
        Text(widget.task.title),
      ]
    );
  }
}
