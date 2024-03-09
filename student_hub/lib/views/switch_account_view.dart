import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:student_hub/widgets/show_account_widget.dart';
import 'package:student_hub/widgets/add_account_widget.dart';
import 'package:student_hub/widgets/account_list_dialog.dart';
import 'package:student_hub/models/company_user.dart';

class SwitchAccountView extends StatefulWidget {
  const SwitchAccountView({super.key});

  @override
  _SwitchAccountViewState createState() => _SwitchAccountViewState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFBEEEF7),
      actions: <Widget>[
        IconButton(
          icon: const SizedBox(
            width: 25,
            height: 25,
            child: Icon(Icons.search, color: Colors.black),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



class _SwitchAccountViewState extends State<SwitchAccountView> {
  // List of accounts that have logged into the app
  String currentAccountName = '';
  void reloadPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccountView()),
    );
  }
  void updateAccountName(String name) {
    setState(() {
      currentAccountName = name;
    });
  }

  void _shhowAccountList(BuildContext ctx, List<CompanyUser> accounts) {
    print('Show Account List');
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AccountListDialog(
              accounts,
              (CompanyUser companyUser) {
                for (var account in accounts) {
                  account.isLogin = false;
                }
                companyUser.isLogin = true;
                updateAccountName(companyUser.fullName);
                reloadPage();
              },
              updateAccountName,
              reloadPage,

            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const _AppBar(),
        backgroundColor: const Color(0xFFBEEEF7),
    body: Column(
      children: <Widget>[
        // If there are no accounts, show AddAccountWidget, else show a dropdown list of accounts
        accounts.isEmpty
            ? const AddAccountWidget()
            : TextButton(
                  onPressed: () {
                    // Settings button pressed
                    _shhowAccountList(context, accounts);
                  },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0,0),
                    child: Text(
                        accounts.where((element) => element.isLogin == true).first.fullName,
                        style: const TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold)
                    ),
                  ),
                  Transform.rotate(
                    angle: -90 * 3.14159 / 180, // Convert degrees to radians
                    child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0),
                  ),
                ],
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width:100,
              height: 100,
              child: Image.asset('assets/images/avatar_default_img.png'),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10), // Set the padding you want
          child: Divider(color: Colors.black, thickness: 0.5),
        ),
        Container(
          color: const Color(0xFFBEEEF7),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    // Profiles button pressed
                  },
                  icon: const Icon(Icons.person, color: Colors.black, size: 28.0),
                  label: const Text('Profiles', style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.normal)),
                ),
              ),
              const Divider(color: Colors.black, thickness: 0.5,),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    // Settings button pressed
                  },
                  icon: const Icon(Icons.settings, color: Colors.black, size: 28.0),
                  label: const Text('Settings', style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.normal)),
                ),
              ),
              const Divider(color: Colors.black, thickness: 0.5,),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    // Log out button pressed
                  },
                  icon: const Icon(Icons.logout, color: Colors.black, size: 28.0),
                  label: const Text('Log out', style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.normal)),
                ),
              ),
              const Divider(color: Colors.black, thickness: 0.5,),
            ],
          ),
    ),
      ],
    ),
    );
  }
}