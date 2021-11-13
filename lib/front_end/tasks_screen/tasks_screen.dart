import 'package:flutter/material.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';
import 'package:aplikacija_projekat/back_end/tasks_screen/tasks_screen_be.dart';

class TasksScreenNavigator extends StatelessWidget {
  const TasksScreenNavigator({Key? key}) : super(key: key);

  final TasksScreen tasksScreen = const TasksScreen();

  void acceptedTaskAction(TaskData taskData) {
    TasksScreenBE.addTask(taskData);
    tasksScreen.acceptedTaskAction();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch(settings.name) {
          case '/':
            builder = (BuildContext context) => const Center(child: Text('tasks'));
            break;
          default:
            builder = (BuildContext context) => Container();
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}

///________________________________________________________________________________________
class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  void acceptedTaskAction() {
    // TODO - show a message or do something else
    print('Task is accepted and added to the TODO list...');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

