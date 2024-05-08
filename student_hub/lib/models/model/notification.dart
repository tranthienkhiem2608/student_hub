import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/models/model/interview.dart';
import 'package:student_hub/models/model/meetingRoom.dart';

class Notification {
  int? id;
  String? createAt;
  String? updateAt;
  String? deletedAt;
  int? notifyFlag;
  int? typeNotifyFlag;
  String? title;
  User? receiver;
  User? sender;
  Message? messageId;
  String? content;
  Interview? interview;
  MeetingRoom? meetingRoom;

  Notification({
    this.id,
    this.createAt,
    this.updateAt,
    this.deletedAt,
    this.notifyFlag,
    this.typeNotifyFlag,
    this.title,
    this.receiver,
    this.sender,
    this.messageId,
    this.content,
    this.interview,
    this.meetingRoom,
  });

  Map<String, dynamic> toMapNotification() {
    return {
      'id': id,
      'notifyFlag': notifyFlag,
      'title': title,
      'receiver': receiver!.toMapUser(),
      'sender': sender!.toMapUser(),
      'messageId': messageId!.toMapSendMessage(),
      'content': content,
    };
  }

  factory Notification.fromMapNotification(Map<String, dynamic> map) {
    return Notification(
        id: map['id'],
        createAt: map['createAt'],
        updateAt: map['updateAt'],
        deletedAt: map['deletedAt'],
        notifyFlag: map['notifyFlag'],
        typeNotifyFlag: map['typeNotifyFlag'],
        title: map['title'],
        content: map['content'],
        receiver: User.fromMapUserNotification(map['receiver']),
        sender: User.fromMapUserNotification(map['sender']),
        messageId: Message.fromMapMessage(map['messageId']),
        interview: map['interview'] == null
            ? null
            : Interview.fromMapInterview(map['interview']),
        meetingRoom: map['meetingRoom'] == null
            ? null
            : MeetingRoom.fromMapMeetingRoom(map['meetingRoom']));
  }
}
