import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleInterviewDialog extends StatefulWidget{
  const ScheduleInterviewDialog({super.key});

  @override
  _ScheduleInterviewDialogState createState() => _ScheduleInterviewDialogState();
}

class _ScheduleInterviewDialogState extends State<ScheduleInterviewDialog>{

  DateTime? _selectedDateStart;
  TimeOfDay? _selectedTimeStart;
  DateTime? _selectedDateEnd;
  TimeOfDay? _selectedTimeEnd;

  void _showDatePicker(String dateType) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    ).then((value) {
      if (value == null) {
        return;
      }
      print('Picked date: $value');  // Add this line
      setState(() {
        dateType == 'start' ? _selectedDateStart = value : _selectedDateEnd = value;
      });
      print('Updated date: ${dateType == 'start' ? _selectedDateStart : _selectedDateEnd}');  // Add this line
    });
  }

  void _showTimePicker(String timeType) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {

        timeType == 'start' ? _selectedTimeStart = value : _selectedTimeEnd = value;
      });
    });
  }

  String calculateDuration(DateTime startDate, TimeOfDay startTime, DateTime endDate, TimeOfDay endTime) {
    if (startDate == null || startTime == null || endDate == null || endTime == null) {
      return 'No duration selected';
    }


    // Combine date and time into DateTime objects
    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    DateTime endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );

    // Calculate duration
    Duration duration = endDateTime.difference(startDateTime);
    String durationStr = '';

    if (duration.inDays > 0) {
      durationStr += '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ';
    }
    if (duration.inHours.remainder(24) > 0) {
      durationStr += '${duration.inHours.remainder(24)} hour${duration.inHours.remainder(24) > 1 ? 's' : ''} ';
    }
    if (duration.inMinutes.remainder(60) > 0) {
      durationStr += '${duration.inMinutes.remainder(60)} minute${duration.inMinutes.remainder(60) > 1 ? 's' : ''}';
    }

    return durationStr.trim();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(

        padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Schedule an interview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Title", style: TextStyle(fontSize: 16)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Catch up meeting',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.0),
              ),
              maxLines: null,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Start Time", style: TextStyle(fontSize: 16)),
            ),
            Row(
              children: <Widget>[
                Text(
                  _selectedDateStart == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_selectedDateStart!),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_month_sharp, color: Colors.blueGrey),
                  onPressed: () {
                    _showDatePicker('start');
                  },
                ),
                Text(
                  _selectedTimeStart == null
                      ? 'No Time Chosen'
                      : _selectedTimeStart?.format(context) ?? '',
                  style: const TextStyle(fontSize: 16),
                ),// Add your DatePicker widget here
                IconButton (
                  icon: const Icon(Icons.access_time, color: Colors.blueGrey),
                  onPressed: () async {
                    _showTimePicker('start');
                  },
                ),
                // Add your TimePicker widget here
              ],
            ),
            SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("End Time", style: TextStyle(fontSize: 16)),
            ),
            Row(
              children: <Widget>[
                Text(
                  _selectedDateEnd == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_selectedDateEnd!),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_month_sharp, color: Colors.blueGrey),
                  onPressed: (){_showDatePicker('end');
                  },
                ),
                Text(
                  _selectedTimeEnd == null
                      ? 'No Time Chosen'
                      : _selectedTimeEnd?.format(context) ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.access_time, color: Colors.blueGrey),
                  onPressed: () {

                    _showTimePicker('end');
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _selectedDateStart != null && _selectedTimeStart != null && _selectedDateEnd != null && _selectedTimeEnd != null
                    ? 'Duration: ${calculateDuration(_selectedDateStart!, _selectedTimeStart!, _selectedDateEnd!, _selectedTimeEnd!)}'
                    : 'No duration selected',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                    });
                    // Handle send action here
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text("Send Invite", style: TextStyle(color: Colors.white)),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

}