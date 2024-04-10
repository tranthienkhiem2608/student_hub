import 'package:flutter/material.dart';
import 'package:student_hub/models/model/language.dart';

class PopUpLanguagesEditWidget extends StatefulWidget {
  final Function(String) _deleteLanguage;
  final List<Language> languages;

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
      title: Text(
        'Edit Language',
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      content: SizedBox(
        height: 200.0,
        child: SingleChildScrollView(
          child: Column(
            children: widget.languages.map((language) {
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(language.languageName!),
                        SizedBox(width: 5.0),
                        Text(language.level!),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget._deleteLanguage(language.languageName!);
                      setState(() {
                        widget.languages.remove(language);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
          ),
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
          child: Text('Done'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
