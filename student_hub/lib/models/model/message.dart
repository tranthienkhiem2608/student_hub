import 'package:student_hub/models/model/meetingRoom.dart';
import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/interview.dart';

class Message {
  int? id;
  String? createAt;
  String? updateAt;
  String? deletedAt;
  int? senderId;
  int? receiverId;
  int? projectId;
  User? sender;
  User? receiver;
  String? content;
  int? messageFlag;
  ProjectCompany? project;
  int? messageId;
  bool? checkRead = false;
  String? typeNotifyFlag;
  String? notifyFlag;
  Interview? interview;
  MeetingRoom? meetingRoom;
  Notify? notification;

  Message({
    this.id,
    this.createAt,
    this.updateAt,
    this.deletedAt,
    this.senderId,
    this.receiverId,
    this.projectId,
    this.sender,
    this.receiver,
    this.content,
    this.messageFlag,
    this.project,
    this.messageId,
    this.checkRead,
    this.notifyFlag,
    this.typeNotifyFlag,
    this.interview,
    this.meetingRoom,
    this.notification,
  });

  Map<String, dynamic> toMapSendMessage() {
    return {
      'projectId': projectId,
      'content': content,
      'messageFlag': messageFlag,
      'senderId': sender!.id,
      'receiverId': receiver!.id,
    };
  }

  factory Message.fromMapMessage(Map<String, dynamic> map) {
    return Message(
      // notifyFlag: map['notifyFlag'] ?? 1,
      id: map['id'],
      createAt: map['createdAt'],
      content: map['content'],
      sender: User.fromMapUserChat(map['sender']),
      receiver: User.fromMapUserChat(map['receiver']),
      interview: map['interview'] == null
          ? null
          : Interview.fromMapInterview(map['interview']),
      project: map['project'] == null
          ? null
          : ProjectCompany.fromMapAllProject(map['project']),
    );
  }

  static List<Message> formListMapMessage(List<dynamic> list) {
    List<Message> messages = [];
    for (var message in list) {
      messages.add(Message.fromMapMessage(message));
    }
    return messages;
  }

  factory Message.fromNewMessage(Map<String, dynamic> map) {
    return Message(
      notifyFlag: map['notification']['notifyFlag'],
      typeNotifyFlag: map['notification']['typeNotifyFlag'],
      id: map['notification']['message']['id'],
      content: map['notification']['message']['content'],
      sender: User.fromMapUserChat(map['notification']['sender']),
      receiver: User.fromMapUserChat(map['notification']['receiver']),
      projectId: map['notification']['message']['projectId'],
      createAt: map['notification']['message']['createdAt'],
      messageFlag: map['messageFlag'],
      messageId: map['notification']['messageId'],
      interview: map['notification']['message']['interview'] == null
          ? null
          : Interview.fromMapInterview(
              map['notification']['message']['interview']),
      meetingRoom: map['notification']['message']['interview'] == null
          ? null
          : MeetingRoom.fromMapMeetingRoom(
              map['notification']['message']['interview']['meetingRoom']),
    );
  }

  factory Message.fromMapLastMessage(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      createAt: map['createdAt'],
      content: map['content'],
      sender: User.fromMapUserChat(map['sender']),
      receiver: User.fromMapUserChat(map['receiver']),
      interview: map['interview'] == null
          ? null
          : Interview.fromMapInterview(map['interview']),
      project: map['project'] == null
          ? null
          : ProjectCompany.fromMapAllProject(map['project']),
      notification: map['notifications'] == null
          ? null
          : Notify.fromMapNoteLastMessage(map['notifications']),
    );
  }

  static List<Message> formListMapLastMessage(List<dynamic> list) {
    List<Message> messages = [];
    for (var message in list) {
      messages.add(Message.fromMapLastMessage(message));
    }
    return messages;
  }

  factory Message.fromMapNote(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      createAt: map['createdAt'],
      content: map['content'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      projectId: map['projectId'],
      messageFlag: map['messageFlag'],
      interview: map['interview'] == null
          ? null
          : Interview.fromMapInterview(map['interview']),
    );
  }
}
