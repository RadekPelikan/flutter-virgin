import 'package:flutter/material.dart';
import 'package:todos/task.dart';

class SharedState
    extends InheritedWidget {
  const SharedState({
    super.key,
    required this.color,
    required super.child, 
    required this.tasks, 
  });

  final Color color;
  final List<Task> tasks;

  static SharedState? maybeOf(
    BuildContext context,
  ) {
    return context
        .dependOnInheritedWidgetOfExactType<
          SharedState
        >();
  }

  static SharedState of(
    BuildContext context,
  ) {
    final SharedState? result = maybeOf(
      context,
    );
    assert(
      result != null,
      'No FrogColor found in context',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(
    SharedState oldWidget,
  ) => color != oldWidget.color;
}
