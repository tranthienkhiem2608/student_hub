import 'package:flutter/material.dart';

class PopUpEducationEditWidget extends StatefulWidget {
  final Function addEducation;
  final Function deleteEducation;
  final String schoolName;
  final int startYear;
  final int endYear;

  PopUpEducationEditWidget(this.addEducation, this.deleteEducation, this.schoolName, this.startYear, this.endYear);

  @override
  _PopUpEducationWidgetState createState() => _PopUpEducationWidgetState();
}

class _PopUpEducationWidgetState extends State<PopUpEducationEditWidget> {
  late TextEditingController _schoolNameController;
  late TextEditingController _startYearController;
  late TextEditingController _endYearController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _schoolNameController = TextEditingController(text: widget.schoolName);
    _startYearController = TextEditingController(text: widget.startYear.toString());
    _endYearController = TextEditingController(text: widget.endYear.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Education', textAlign: TextAlign.center),
      content: SizedBox(
        key: _formKey,
        height: 200.0,
        child: Column(
          children: [
            Row(
              children: [
                Text('School Name: '),
                Expanded(
                  child: TextFormField(
                    controller: _schoolNameController,
                    onChanged: (value) {
                      _schoolNameController.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter school name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Start Year: '),
                Expanded(
                  child: TextFormField(
                    controller: _startYearController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _startYearController.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter start year';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('End Year: '),
                Expanded(
                  child: TextFormField(
                    controller: _endYearController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _endYearController.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter end year';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid number';
                      }
                      if (int.parse(value) < int.parse(_startYearController.text)) {
                        return 'End year cannot be before start year';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.deleteEducation(widget.schoolName);
              widget.addEducation(_schoolNameController.text, int.parse(_startYearController.text), int.parse(_endYearController.text));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}