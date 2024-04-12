import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: Text('Edit language',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF406AFF),
          )),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      content: SizedBox(
        height: 100.0,
        width: 270.0,
        child: SingleChildScrollView(
          child: Column(
            children: widget.languages.map((language) {
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(language.languageName!, style: GoogleFonts.poppins(fontSize: 16.0)),
                        SizedBox(width: 5.0),
                        Text(language.level!, style: GoogleFonts.poppins(fontSize: 16.0)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Color(0xFF777B8A), size: 17.0),
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
           style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(244, 213, 222, 255),
          ),
            child: Text('Cancel', style: GoogleFonts.poppins(color: Color(0xFF406AFF), fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFF406AFF),
          ),
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
