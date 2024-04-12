import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/language.dart';

class ShowLanguagesWidget extends StatelessWidget {
  final List<Language> languages;

  ShowLanguagesWidget({required this.languages});

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
    return ListView.builder(
      itemCount: languages.length,
      itemBuilder: (context, index) {
        Color backgroundColor = _getBackgroundColorForLevel(_getColorForLevel(languages[index].level!));

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languages[index].languageName!,
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              
              SizedBox(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                    color: backgroundColor, // Màu nền nhạt tương ứng với mức độ ngôn ngữ
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
              ),
            ],
          ),
        );
      },
    );
  }
}
