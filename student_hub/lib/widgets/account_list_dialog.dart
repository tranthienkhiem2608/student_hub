import 'package:flutter/material.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/widgets/show_account_widget.dart';

class AccountListDialog extends StatelessWidget {
  final List<CompanyUser> accounts;
  Function(CompanyUser) onAccountSwitched;
  Function reloadPage;

  AccountListDialog(this.accounts, this.onAccountSwitched, this.reloadPage, {super.key});  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 350,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
                children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 110.0),
                child:Text(
                  'Switch Accounts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0), // Set the padding you want
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
        ]
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
                height: 250,
                child: ShowAccountWidget(
                  accounts,
                  onAccountSwitched,
                  reloadPage,

                ),
            ),
          ],
        ),
      ),
    );
  }
}
