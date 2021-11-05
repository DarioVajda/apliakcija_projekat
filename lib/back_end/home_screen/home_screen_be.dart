import 'package:flutter/material.dart';
import 'dart:math';

/// TODO - OVAJ CEO PROGRAM TREBA DA SE PROMENI KAD BUDEM RADIO BACK-END

/// Task data class
class TaskData {
  String username;
  IconData profilePicture; // ovo je mozda visak podatak jer ce ikona moci da se dobije iz profila osobe
  String title;
  String description;
  String topic;
  ImageProvider? image;
  double price;
  String taskType; // ovo ce mozda biti enum umesto String-a
  DateTime dueDate;

  TaskData({
    required this.username,
    required this.title,
    this.description = '',
    required this.dueDate,
    required this.profilePicture,
    required this.topic,
    required this.price,
    required this.taskType,
    this.image
  });
}
///_____________________________________________________

class HomeScreenTaskListBE {
  // trebam da pretvorim ovu funkciju u async i da je tako isprobam

  static List<TaskData> getHomeScreenList(String? filter) {
    /// region Inicijalizacija
    String description = 'Programming is the process of creating a set of instructions that tell a computer how to perform a task. Programming can be done using a variety of computer programming languages, such as JavaScript, Python, and C++. Computer programming is the process of designing and building an executable computer program to accomplish a specific computing result or to perform a specific task.';
    List<String> images = [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Gutenberg_Bible%2C_Lenox_Copy%2C_New_York_Public_Library%2C_2009._Pic_01.jpg/894px-Gutenberg_Bible%2C_Lenox_Copy%2C_New_York_Public_Library%2C_2009._Pic_01.jpg',
      'https://images.prismic.io/frameworkmarketplace/cca31de3-3b75-4932-af96-7646b7eba6c7__DSC3630-Edit-cropped.jpg?auto=compress,format',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Triangle.Equilateral.svg/440px-Triangle.Equilateral.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Caffeine_%281%29_3D_ball.png/460px-Caffeine_%281%29_3D_ball.png'
    ];
    List<TaskData> list = [];
    Random random = Random();
    /// endregion
    String f;
    for(int i = 0; i < 10; i++) {
      if(filter == null) {
        f = 'topic' + random.nextInt(10).toString();
      }
      else {
        f = filter;
      }
      list.add(
        TaskData(
          username: 'username' + random.nextInt(10).toString(),
          profilePicture: Icons.person,
          title: 'Short title',
          description: description,
          topic: f,
          price: 9.99,
          taskType: 'Short Homework',
          dueDate: DateTime(2022, 2, random.nextInt(29)),
          image: NetworkImage(images[random.nextInt(images.length)])
        )
      );
    }
    return list;
  }

  static List<String> getHomeScreenFilters() {
    List<String> filters = [];
    for(int i = 0; i < 10; i++) {
      filters.add('topic' + i.toString());
    }
    return filters;
  }
}