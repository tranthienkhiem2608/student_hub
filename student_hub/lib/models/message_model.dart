import 'package:student_hub/models/user_chat_model.dart';

class Message {
  final User sender;
  final String avatar; // Store the avatar file path as a string
  final String time;
  final int unreadCount;
  final String text;
  final bool isRead;

  Message({
    required this.sender,
    required this.avatar,
    required this.time,
    this.unreadCount = 0,
    required this.text,
    this.isRead = false, // Default to unread
  });
}

final List<Message> recentChats = [
  Message(
    sender: addison,
    avatar: 'assets/images/chat_avatar/Addison.jpg',
    time: '01:25',
    text: "typing...",
    unreadCount: 1,
  ),
  Message(
    sender: jason,
    avatar: 'assets/images/chat_avatar/Jason.jpg',
    time: '12:46',
    text: "Will I be in it?",
    unreadCount: 1,
  ),
  Message(
    sender: deanna,
    avatar: 'assets/images/chat_avatar/Deanna.jpg',
    time: '05:26',
    text: "That's so cute.",
    unreadCount: 3,
  ),
  Message(
      sender: nathan,
      avatar: 'assets/images/chat_avatar/Nathan.jpg',
      time: '12:45',
      text: "Let me see what I can do.",
      unreadCount: 2),
];

final List<Message> allChats = [
  Message(
    sender: virgil,
    avatar: 'assets/images/chat_avatar/Virgil.jpg',
    time: '12:59',
    text: "No! I just wanted",
    unreadCount: 0,
    isRead: true,
  ),
  Message(
    sender: stanley,
    avatar: 'assets/images/chat_avatar/Stanley.jpg',
    time: '10:41',
    text: "You did what?",
    unreadCount: 1,
    isRead: false,
  ),
  Message(
    sender: leslie,
    avatar: 'assets/images/chat_avatar/Leslie.jpg',
    time: '05:51',
    unreadCount: 0,
    isRead: true,
    text: "just signed up for a tutor",
  ),
  Message(
    sender: judd,
    avatar: 'assets/images/chat_avatar/Judd.jpg',
    time: '10:16',
    text: "May I ask you something?",
    unreadCount: 2,
    isRead: false,
  ),
];

final List<Message> messages = [
  Message(
    sender: addison,
    time: '12:09 AM',
    avatar: addison.avatar,
    text: "...",
  ),
  Message(
    sender: currentUser,
    time: '12:05 AM',
    avatar: currentUser.avatar,
    isRead: true,
    text: "I’m going home.",
  ),
  Message(
    sender: currentUser,
    avatar: currentUser.avatar,
    time: '12:05 AM',
    isRead: true,
    text: "See, I was right, this doesn’t interest me.",
  ),
  Message(
    sender: addison,
    time: '11:58 PM',
    avatar: addison.avatar,
    text: "I sign your paychecks.",
  ),
  Message(
    sender: addison,
    time: '11:58 PM',
    avatar: addison.avatar,
    text: "You think we have nothing to talk about?",
  ),
  Message(
    sender: currentUser,
    avatar: currentUser.avatar,
    time: '11:45 PM',
    isRead: true,
    text:
        "Well, because I had no intention of being in your office. 20 minutes ago",
  ),
  Message(
    sender: addison,
    time: '11:30 PM',
    avatar: addison.avatar,
    text: "I was expecting you in my office 20 minutes ago.",
  ),
];
