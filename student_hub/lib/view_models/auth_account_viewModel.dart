
import 'package:flutter/material.dart';
import 'package:student_hub/models/company_user.dart';

import '../views/auth/switch_account_view.dart';
import '../widgets/account_list_dialog.dart';

class AuthAccountViewModel {
  final BuildContext context;

  AuthAccountViewModel(this.context);
  void reloadPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccountView()),
    );
  }


  Future<void> showAccountList(List<CompanyUser> accounts) async {
    print('Show Account List');
    return showModalBottomSheet(
        context: context,
        builder: (_)  {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AccountListDialog(
              accounts,
              (CompanyUser companyUser) async {
                for (var account in accounts) {
                  account.isLogin = false;
                }
                companyUser.isLogin = true;
                // Call a method to reload the page
              },
                reloadPage,
              // Pass the method to reload the page
            ),
          );
        });
  }

}