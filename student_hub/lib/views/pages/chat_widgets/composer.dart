import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

Container buildChatComposer(BuildContext context) { // Pass BuildContext as a parameter
  final isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode; // Retrieve isDarkMode here
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: isDarkMode ? Color(0xFF212121) : Colors.white,
    height: 100,
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFF406AFF),
          child: const Icon(
            Icons.today,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            height: 60,
            decoration: BoxDecoration(
              color: isDarkMode ? Color.fromARGB(255, 58, 58, 58) : Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: Color(0xFF406AFF),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message ...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                Icon(
                  Icons.attach_file,
                  color: Color(0xFF406AFF),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        const CircleAvatar(
          backgroundColor: Color(0xFF406AFF),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
