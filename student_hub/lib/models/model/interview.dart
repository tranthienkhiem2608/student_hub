import 'package:flutter/material.dart';

class Interview{
  String id;
  String title;
  DateTime startDate;
  TimeOfDay startTime;
  DateTime endDate;
  TimeOfDay endTime;
  String disableFlag;

  Interview({
    required this.id,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.disableFlag,
  });

  Map<String, dynamic> toMapInterview() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate,
      'startTime': startTime,
      'endDate': endDate,
      'endTime': endTime,
      'disableFlag': disableFlag,
    };
  }

  factory Interview.fromMapInterview(Map<String, dynamic> map) {
    return Interview(
      id: map['id'],
      title: map['title'],
      startDate: map['startDate'],
      startTime: map['startTime'],
      endDate: map['endDate'],
      endTime: map['endTime'],
      disableFlag: map['disableFlag'],
    );
  }
}