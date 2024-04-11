import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpEducationEditWidget extends StatefulWidget {
  final Function addEducation;
  final Function deleteEducation;
  final String schoolName;
  final int startYear;
  final int endYear;

  PopUpEducationEditWidget(this.addEducation, this.deleteEducation,
      this.schoolName, this.startYear, this.endYear);

  @override
  _PopUpEducationWidgetState createState() => _PopUpEducationWidgetState();
}

class _PopUpEducationWidgetState extends State<PopUpEducationEditWidget> {
  late TextEditingController _schoolNameController = TextEditingController();

  String schoolName = '';
  int _startYear = 0;
  int _endYear = 0;
  List<int> yearList = List<int>.generate(
      DateTime.now().year - (DateTime.now().year - 10) + 1,
      (i) => i + (DateTime.now().year - 10)).reversed.toList();
  List<int> yearListStart = [];
  List<int> yearListEnd = [];
  List<int> listYear = [];
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  FixedExtentScrollController scrollControllerStart =
      FixedExtentScrollController();
  FixedExtentScrollController scrollControllerEnd =
      FixedExtentScrollController();
  bool showError = false;

  @override
  void initState() {
    super.initState();
    _schoolNameController = TextEditingController(text: widget.schoolName);
    _startYear = widget.startYear;
    _endYear = widget.endYear;

    int initialItemIndex = yearList.indexOf(DateTime.now().year);
    scrollController =
        FixedExtentScrollController(initialItem: initialItemIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Education', textAlign: TextAlign.center),
      content: SizedBox(
        height: 250.0,
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
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start Year: '),
                Text(_startYear == 0 ? 'Select Year' : _startYear.toString()),
                IconButton(
                    onPressed: () {
                      _endYear == 0
                          ? listYear = yearList
                          : listYear = List<int>.generate(
                                  _endYear - (DateTime.now().year - 10) + 1,
                                  (i) => i + (DateTime.now().year - 10))
                              .reversed
                              .toList();
                      int initialItemIndexStart =
                          listYear.indexOf(DateTime.now().year);
                      scrollControllerStart = FixedExtentScrollController(
                          initialItem: initialItemIndexStart);
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                                child: Container(
                              height: 200.0,
                              width: 300.0,
                              color: Colors.white.withOpacity(0.95),
                              child: CupertinoPicker(
                                scrollController: _endYear == 0
                                    ? scrollController
                                    : scrollControllerStart,
                                itemExtent: 40.0,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _startYear = listYear[index];
                                  });
                                },
                                children: listYear
                                    .map((year) =>
                                        Center(child: Text(year.toString())))
                                    .toList(),
                              ),
                            ));
                          });
                    },
                    icon: Icon(Icons.calendar_today)),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('End Year: '),
                Text(_endYear == 0 ? 'Select Year' : _endYear.toString()),
                IconButton(
                    onPressed: () {
                      _startYear == 0
                          ? listYear = yearList
                          : listYear = List<int>.generate(
                              DateTime.now().year - _startYear + 1 + 10,
                              (i) => i + _startYear + 1).reversed.toList();
                      int initialItemIndexEnd =
                          listYear.indexOf(DateTime.now().year);
                      scrollControllerEnd = FixedExtentScrollController(
                          initialItem: initialItemIndexEnd);
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                                child: Container(
                              height: 200.0,
                              width: 300.0,
                              color: Colors.white.withOpacity(0.95),
                              child: CupertinoPicker(
                                scrollController: _startYear == 0
                                    ? scrollController
                                    : scrollControllerEnd,
                                itemExtent: 40.0,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _endYear = listYear[index];
                                  });
                                },
                                children: listYear
                                    .map((year) =>
                                        Center(child: Text(year.toString())))
                                    .toList(),
                              ),
                            ));
                          });
                    },
                    icon: Icon(Icons.calendar_today)),
              ],
            ),
            if (showError == true)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Make sure to fill all the fields',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
            _startYear = 0;
            _endYear = 0;
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            schoolName = _schoolNameController.text;
            print(schoolName);
            if (schoolName != " " && _startYear != 0 && _endYear != 0) {
              widget.deleteEducation(widget.schoolName);
              widget.addEducation(
                schoolName,
                _startYear,
                _endYear,
              );
              Navigator.of(context).pop();
            } else {
              //show text with red color at below end year
              setState(() {
                showError = true;
              });
            }
          },
        ),
      ],
    );
  }
}
