import 'package:student_hub/models/model/meetingRoom.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/interview.dart';

class Message {
  int? id;
  String? createAt;
  int? senderId;
  int? receiverId;
  int? projectId;
  User? sender;
  User? receiver;
  String? content;
  int? messageFlag;
  Interview? interviewId;
  ProjectCompany? project;
  int? messageId;
  bool? checkRead = false;
  Interview? interview;
  MeetingRoom? meetingRoom;

  Message({
    this.id,
    this.createAt,
    this.senderId,
    this.receiverId,
    this.projectId,
    this.sender,
    this.receiver,
    this.content,
    this.messageFlag,
    this.interviewId,
    this.project,
    this.messageId,
    this.checkRead,
    this.interview,
    this.meetingRoom,
  });

  Map<String, dynamic> toMapSendMessage() {
    return {
      'content': content,
      'projectId': project,
      'messageFlag': messageFlag,
      'senderId': sender,
      'receiverId': receiver,
    };
  }

  factory Message.fromMapMessage(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      createAt: map['createdAt'],
      content: map['content'],
      senderId: map['sender']['id'],
      receiverId: map['receiver']['id'],
      interviewId: map['interview'] == null
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
      content: map['notification']['message']['content'],
      senderId: map['notification']['message']['senderId'],
      receiverId: map['notification']['message']['receiverId'],
      projectId: map['notification']['message']['projectId'],
      createAt: map['notification']['message']['createdAt'],
      messageFlag: map['messageFlag'],
      messageId: map['notification']['messageId'],
      interview: map['notification']['interview'] == null
          ? null
          : Interview.fromMapInterview(map['notification']['interview']),
      meetingRoom: map['notification']['meetingRoom'] == null
          ? null
          : MeetingRoom.fromMapMeetingRoom(map['notification']['meetingRoom']),
    );
  }

  factory Message.fromMapLastMessage(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      createAt: map['createdAt'],
      content: map['content'],
      sender: User.fromMapUserChat(map['sender']),
      receiver: User.fromMapUserChat(map['receiver']),
      interviewId: map['interview'] == null
          ? null
          : Interview.fromMapInterview(map['interview']),
      project: map['project'] == null
          ? null
          : ProjectCompany.fromMapAllProject(map['project']),
    );
  }

  static List<Message> formListMapLastMessage(List<dynamic> list) {
    List<Message> messages = [];
    for (var message in list) {
      messages.add(Message.fromMapLastMessage(message));
    }
    return messages;
  }
}
