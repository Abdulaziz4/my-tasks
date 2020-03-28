import 'dart:math';

import 'package:flutter/material.dart';

class Task {
  String text;
  int id = Random.secure().nextInt(2000);
  DateTime date;
  DateTime startTime;
  DateTime finishTime;
  bool check = false;

  Task(
      {@required this.text,
      @required this.date,
      @required this.startTime,
      @required this.finishTime});
}
