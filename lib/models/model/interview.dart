import 'package:student_hub/models/model/meetingRoom.dart';

class Interview {
  int? id;
  String? createAt;
  String? updateAt;
  String? deleteAt;
  String? title;
  String? content;
  DateTime? startTime;
  DateTime? endTime;
  String? duration;
  int? projectId;
  int? senderId;
  int? receiverId;
  int? disableFlag;
  int? meetingRoomId;
  MeetingRoom? meetingRoom;

  Interview({
    this.id,
    this.createAt,
    this.updateAt,
    this.deleteAt,
    this.title,
    this.content,
    this.startTime,
    this.endTime,
    this.duration,
    this.projectId,
    this.senderId,
    this.receiverId,
    this.disableFlag,
    this.meetingRoomId,
    this.meetingRoom,
  });

  Map<String, dynamic> toMapInterview() {
    return {
      'title': title,
      'content': content,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'projectId': projectId,
      'senderId': senderId,
      'receiverId': receiverId,
      'meeting_room_id': meetingRoom!.meeting_room_id,
      'meeting_room_code': meetingRoom!.meeting_room_code,
    };
  }

  Map<String, dynamic> toMapInterviewUpdate() {
    return {
      'title': title,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
    };
  }

  factory Interview.fromMapInterview(Map<String, dynamic> map) {
    return Interview(
      id: map['id'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
      deleteAt: map['deleteAt'],
      title: map['title'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      duration: calculateDuaraion(map['startTime'], map['endTime']),
      disableFlag: map['disableFlag'],
      meetingRoomId: map['meetingRoomId'],
      meetingRoom: map['meetingRoom'] == null
          ? null
          : MeetingRoom.fromMapMeetingRoom(map['meetingRoom']),
    );
  }
}

String calculateDuaraion(String _startTime, String _endTime) {
  DateTime startTime = DateTime.parse(_startTime);
  DateTime endTime = DateTime.parse(_endTime);
  Duration duration = endTime.difference(startTime);
  String durationStr = '';

  if (duration.inDays > 0) {
    durationStr += '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ';
  }
  if (duration.inHours.remainder(24) > 0) {
    durationStr +=
        '${duration.inHours.remainder(24)} hour${duration.inHours.remainder(24) > 1 ? 's' : ''} ';
  }
  if (duration.inMinutes.remainder(60) > 0) {
    durationStr +=
        '${duration.inMinutes.remainder(60)} minute${duration.inMinutes.remainder(60) > 1 ? 's' : ''}';
  }

  return durationStr.trim();
}
