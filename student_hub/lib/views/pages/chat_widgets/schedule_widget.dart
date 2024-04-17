import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/schedule.dart'; // Replace with your actual Schedule model import

class ScheduleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final schedule = Provider.of<Schedule>(context);

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Catch up meeting",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "60 minutes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Start time: ${Schedule.startDateText}", // Replace with your actual start time property
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "End time: ${Schedule.endDateText}", // Replace with your actual end time property
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle join button press
                  },
                  child: Text("Join"),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    // Handle more options button press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
