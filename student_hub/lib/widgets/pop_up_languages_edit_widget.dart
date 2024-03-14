import 'package:flutter/material.dart';

class PopUpLanguagesEditWidget extends StatefulWidget {
  final Function(String) _deleteLanguage;
  final List<Map<String, dynamic>> languages;


  PopUpLanguagesEditWidget(this._deleteLanguage, this.languages);

  @override
  _PopUpLanguagesEditWidgetState createState() =>
      _PopUpLanguagesEditWidgetState();
}

class _PopUpLanguagesEditWidgetState extends State<PopUpLanguagesEditWidget> {
  late String _selectedLanguage;
  late String _selectedLevel;
  List<Map<String, dynamic>> _listLanguagesDelete = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Language'),
      content: Column(
        children: widget.languages.map((language) {
          return Row(
            children: [
              Text(language['name']),
              Text(language['level']),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget._deleteLanguage(language['name']);
                  setState(() {
                    widget.languages.remove(language);
                  });
                },
              ),
            ],
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Done'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}