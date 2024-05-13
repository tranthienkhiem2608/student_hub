import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ShowLanguagesWidget extends StatelessWidget {
  final List<Language> languages;
  final bool isEditing;
  final Function(String) _deleteLanguage;

  ShowLanguagesWidget({
    required this.languages,
    required this.isEditing,
    required Function(String) deleteLanguage,
  }) : _deleteLanguage = deleteLanguage;

  Color _getColorForLevel(String level) {
    switch (level) {
      case 'Native':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Basic':
        return Colors.red;
      case 'Advanced':
        return Colors.blue;
      case 'Bản ngữ':
        return Colors.green;
      case 'Trung bình':
        return Colors.orange;
      case 'Cơ bản':
        return Colors.red;
      case 'Nâng cao':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  Color _getBackgroundColorForLevel(Color color) {
    // Giảm độ sáng của màu gốc để có màu nhạt hơn
    return color.withOpacity(0.18);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return ListView.builder(
      itemCount: languages.length,
      itemBuilder: (context, index) {
        Color backgroundColor = _getBackgroundColorForLevel(
            _getColorForLevel(languages[index].level!));

        return Padding(
          padding: const EdgeInsets.fromLTRB(
              20, 10, 15, 5), // Điều chỉnh giá trị padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment
                .center, // Căn chỉnh các widget theo chiều dọc
            children: [
              Expanded(
                child: Text(
                  languages[index].languageName!,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 10, // Khoảng cách giữa Text và Container
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  languages[index].level!,
                  style: TextStyle(
                    color: _getColorForLevel(languages[index].level!),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                visible: isEditing!,
                child: Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/delete.jpg',
                        width: 21,
                        height: 21,
                      ),
                      onPressed: () {
                        _deleteLanguage(languages[index].languageName!);
                      },
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
