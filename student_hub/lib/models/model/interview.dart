import 'package:flutter/material.dart';

class Interview {
  int? id;
  String? createAt;
  String? updateAt;
  String? deleteAt;
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  String? disableFlag;

  Interview({
    this.id,
    this.createAt,
    this.updateAt,
    this.deleteAt,
    this.title,
    this.startDate,
    this.endDate,
    this.disableFlag,
  });

  Map<String, dynamic> toMapInterview() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'disableFlag': disableFlag,
    };
  }

  factory Interview.fromMapInterview(Map<String, dynamic> map) {
    return Interview(
      id: map['id'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
      deleteAt: map['deleteAt'],
      title: map['title'],
      startDate: map['startTime'],
      endDate: map['endTime'],
      disableFlag: map['disableFlag'],
    );
  }
}
