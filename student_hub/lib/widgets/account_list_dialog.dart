import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/widgets/show_account_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class AccountListDialog extends StatelessWidget {
  final User accounts;
  Function reloadPage;

  AccountListDialog(this.accounts, this.reloadPage, {super.key});
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return SingleChildScrollView(
      child: Container(
        height: 310,
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF212121) : Colors.white,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28), // Độ cong của góc trên bên trái
          topRight: Radius.circular(28), // Độ cong của góc trên bên phải
        ), // Độ cong của góc container
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 110.0),
                child: Text(
                  'Switch Accounts',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black, // Màu chữ của tiêu đề
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 195,
              child: ShowAccountWidget(
                accounts,
                reloadPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
