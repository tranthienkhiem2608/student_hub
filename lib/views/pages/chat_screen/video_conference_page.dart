import 'package:flutter/material.dart';
import 'package:student_hub/constant/const_key.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatefulWidget {
  final String conferenceID;
  final User user;

  const VideoConferencePage({
    super.key,
    required this.conferenceID,
    required this.user,
  });

  @override
  _VideoConferencePageState createState() => _VideoConferencePageState();
}

class _VideoConferencePageState extends State<VideoConferencePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID:
            appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: widget.user.id.toString(),
        userName: widget.user.fullname.toString(),
        conferenceID: widget.conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
