import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

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
    'language1'.tr(),
    'language2'.tr(),
    'language3'.tr(),
    'language4'.tr(),
    'language5'.tr(),
    'language6'.tr(),
    'language7'.tr(),
    'language8'.tr(),
    'language9'.tr(),
    'language10'.tr(),
    'language11'.tr(),
    'language12'.tr(),
    'language13'.tr(),
    'language14'.tr(),
    'language15'.tr(),
    'language16'.tr()
    // Add more languages here
  ];

  final List<String> _levels = ['level4'.tr(), 'level2'.tr(), 'level1'.tr(), 'level3'.tr()];
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return AlertDialog(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
      title: Text('popup_language1'.tr(),
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF406AFF),
          )),
      content: SizedBox(
        height: 400.0,
        width: 300.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Để căn chỉnh văn bản theo chiều ngang
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20), // Khoảng cách dưới cùng
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('popup_language2'.tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
              ),
            ),
            SizedBox(height: 10),
            DropdownSearch<String>(
              asyncItems: (filter) async => await getData(filter,
                  checkLanguageExits(widget.languagesSelected, languages)),
              compareFn: (item, selectedItem) => item == selectedItem,
              dropdownBuilder: (context, selectedItem) {
                return Text(
                  selectedItem ?? "popup_language2".tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                );
              },
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue ?? "null";
                });
              },
              popupProps: PopupProps.menu(
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
                  cursorColor: Color(0xFF406AFF),
                  decoration: InputDecoration(
                    hintText: "popup_language6".tr(),
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('popup_language3'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  )),
            ),
            Column(
              children: _levels.map((String level) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    level,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  leading: Radio<String>(
                    value: level,
                    groupValue: _selectedLevel,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLevel = value ?? "null";
                      });
                    },
                    overlayColor:
                        MaterialStateProperty.all<Color>(Color(0xFF406AFF)),
                    activeColor: Color(0xFF406AFF),
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Color(0xFF406AFF); // Màu khi radio được chọn
                      }
                      return isDarkMode
                          ? Colors.white
                          : Colors.black; // Màu khi radio không được chọn
                    }),
                  ),
                );
              }).toList(),
            ),
            if (showError == true)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'popup_language7'.tr(),
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(244, 213, 222, 255),
          ),
          child: Text('popup_language5'.tr(),
              style: GoogleFonts.poppins(
                  color: Color(0xFF406AFF), fontWeight: FontWeight.w500)),
          onPressed: () {
            Navigator.of(context).pop();
            _selectedLanguage = "null";
            _selectedLevel = "null";
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFF406AFF),
          ),
          child: Text('popup_language4'.tr(),
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w500)),
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
  bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
  return Container(
      color: isDarkMode ? Color(0xFF2f2f2f) : Colors.white,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
          child: Column(
            children: [
              Text(
                item,
                style: GoogleFonts.poppins(
                  color: isDarkMode
                      ? isSelected
                          ? Color(0xFF406AFF)
                          : Colors.white
                      : isSelected
                          ? Color(0xFF406AFF)
                          : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Divider(
                color: Color(0xFF777B8A),
                thickness: 0.2,
              ),
            ],
          )));
}

Widget _customLoadingBuilder(BuildContext context, String item) {
  bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
  return Container(
      color: isDarkMode ? Color(0xFF2f2f2f) : Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF406AFF),
        ),
      ));
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
