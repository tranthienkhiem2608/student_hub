import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/widgets/add_account_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ShowAccountWidget extends StatefulWidget {
  final User _companyUser;
  final List<ValueNotifier<bool>> _isVisible;
  final Function reloadPage;

  ShowAccountWidget(this._companyUser, this.reloadPage, {super.key})
      : _isVisible = List.generate(
          _companyUser.role!.length,
          (index) => ValueNotifier<bool>(true),
        );

  @override
  _ShowAccountWidgetState createState() => _ShowAccountWidgetState();
}

class _ShowAccountWidgetState extends State<ShowAccountWidget> {
  late SharedPreferences prefs;
  late int role = 0; // Initialize role with a default value

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    updateRole(prefs.getInt('role') ?? 0);
  }

  void updateRole(int newRole) {
    setState(() {
      role = newRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return ListView.builder(
      itemCount: widget._companyUser.role!.length == 1
          ? widget._companyUser.role!.length + 1
          : widget._companyUser.role!.length,
      itemBuilder: (ctx, index) {
        if (index == widget._companyUser.role!.length &&
            widget._companyUser.role!.length < 2) {
          return AddAccountWidget(widget._companyUser);
        } else {
          return InkWell(
            onTap: () {
              primaryFocus?.unfocus();
              prefs.setInt('role', widget._companyUser.role![index]);
              Navigator.of(context).pop();
              widget.reloadPage(widget._companyUser);
            },
            highlightColor: Colors.grey,
            child: ListTile(
              leading: Image.asset(widget._companyUser.role?[index] == 0
                  ? 'assets/icons/student_account.png'
                  : 'assets/icons/company_account.png'),
              title: Text(
                widget._companyUser.fullname!,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                widget._companyUser.role?[index] == 0 ? 'accountSwitchPage_ProfileCreation2'.tr() : 'accountSwitchPage_ProfileCreation1'.tr(),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              trailing: role == widget._companyUser.role![index]
                  ? const Icon(Icons.check, color: Color(0xFF406AFF))
                  : null,
            ),
          );
        }
      },
    );
  }
}
