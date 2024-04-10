import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:student_hub/models/model/language.dart';

class PopUpLanguagesWidget extends StatefulWidget {
  final Function _addTask;
  final List<Language> languagesSelected;
  const PopUpLanguagesWidget(this._addTask, this.languagesSelected,
      {super.key});

  @override
  _PopUpLanguagesWidgetState createState() => _PopUpLanguagesWidgetState();
}

class _PopUpLanguagesWidgetState extends State<PopUpLanguagesWidget> {
  String _selectedLanguage = "null";
  String _selectedLevel = "null";

  List<String> checkLanguageExits(
      List<Language> languagesSelected, List<String> languages) {
    List<String> existingLanguages = [];
    for (var i = 0; i < languagesSelected.length; i++) {
      //remove the existing language from the list
      if (languages.contains(languagesSelected[i].languageName)) {
        existingLanguages.add(languagesSelected[i].languageName!);
      }
      {
        languages.remove(languagesSelected[i].languageName);
      }
    }
    return languages;
  }

  final List<String> languages = [
    'English',
    'French',
    'Spanish',
    'German',
    'Italian',
    'Portuguese',
    'Russian',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
    'Hindi',
    'Bengali',
    'Urdu',
    'Turkish',
    'Vietnamese',
    // Add more languages here
  ];

  final List<String> _levels = ['Native', 'Intermediate', 'Basic', 'Advanced'];
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Language'),
      content: SizedBox(
        height: 400.0,
        width: 300.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Level',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            DropdownSearch<String>(
              asyncItems: (filter) async => await getData(filter,
                  checkLanguageExits(widget.languagesSelected, languages)),
              compareFn: (item, selectedItem) => item == selectedItem,
              dropdownBuilder: (context, selectedItem) {
                return Text(selectedItem ?? "Select Language");
              },
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue ?? "null";
                });
              },
              popupProps: const PopupProps.menu(
                isFilterOnline: true,
                showSearchBox: true,
                showSelectedItems: true,
                loadingBuilder: _customLoadingBuilder,
                itemBuilder: _customItemBuilder,
                favoriteItemProps: FavoriteItemProps(
                  showFavoriteItems: true,
                  favoriteItemsAlignment: MainAxisAlignment.start,
                ),
                searchFieldProps: TextFieldProps(
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: "Search Language",
                    hintText: "Search Language",
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Level',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Column(
              children: _levels.map((String level) {
                return ListTile(
                  title: Text(level),
                  leading: Radio<String>(
                    value: level,
                    groupValue: _selectedLevel,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLevel = value ?? "null";
                      });
                    },
                  ),
                );
              }).toList(),
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
            _selectedLanguage = "null";
            _selectedLevel = "null";
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            // Handle the OK button press
            //check existing language
            print("h" + _selectedLanguage);
            print("hc" + _selectedLevel);
            if (_selectedLanguage != "null" && _selectedLevel != "null") {
              widget._addTask(_selectedLanguage, _selectedLevel);
              Navigator.of(context).pop();
            } else {
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

Widget _customItemBuilder(BuildContext context, String item, bool isSelected) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: Column(
        children: [
          Text(
            item,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
        ],
      ));
}

Widget _customLoadingBuilder(BuildContext context, String item) {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.blue,
    ),
  );
}

Future<List<String>> getData(String? filter, List<String> languages) async {
  await Future.delayed(const Duration(milliseconds: 200));
  if (filter!.isNotEmpty) {
    return languages
        .where((skill) => skill.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }
  return languages;
}
