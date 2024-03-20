import 'package:flutter/material.dart';

import '../../widgets/custom_notification/invited_notification.dart';
import '../../widgets/custom_notification/messages_notification.dart';
import '../../widgets/custom_notification/offer_notification.dart';
import '../../widgets/custom_notification/submitted_notification.dart';


class AlertPage extends StatelessWidget {
  AlertPage({Key? key}) : super(key: key);
  List newItems = ["Submitted", "Messages"];
  List todayItems = ["Submitted", "Invited", "Offer", "Messages"];
  List oldesItems = ["Offer", "Messages"];

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New',
                  style: TextStyle(color: Color(0xFF0c9bab), fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: newItems.length,
                itemBuilder: (BuildContext context, int index) {
                  switch (newItems[index]) {
                    case "Submitted":
                      return SubmittedNotification();
                    case "Messages":
                      return MessagesNotification();
                    case "Invited":
                      return InvitedNotification();
                    case "Offer":
                      return OfferNotification();
                    default:
                      return Container();
                  }
                },
              ),
              SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Today',
                  style: TextStyle(color: Color(0xFF0c9bab), fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: todayItems.length,
                itemBuilder: (BuildContext context, int index) {
                  switch (todayItems[index]) {
                    case "Submitted":
                      return SubmittedNotification();
                    case "Messages":
                      return MessagesNotification();
                    case "Invited":
                      return InvitedNotification();
                    case "Offer":
                      return OfferNotification();
                    default:
                      return Container();
                  }
                },
              ),
              SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Oldest',
                  style: TextStyle(color: Color(0xFF0c9bab), fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: oldesItems.length,
                itemBuilder: (BuildContext context, int index) {
                  switch (oldesItems[index]) {
                    case "Submitted":
                      return SubmittedNotification();
                    case "Messages":
                      return MessagesNotification();
                    case "Invited":
                      return InvitedNotification();
                    case "Offer":
                      return OfferNotification();
                    default:
                      return Container();
                  }
                },
              ),

            ],
          ),
        ),
      ),
    ),
    );
  }
}