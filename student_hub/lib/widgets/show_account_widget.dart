import 'package:flutter/material.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/widgets/add_account_widget.dart';

class ShowAccountWidget extends StatefulWidget {
  final List<CompanyUser> _companyUser;
  final List<ValueNotifier<bool>> _isVisible;
  final Function(CompanyUser) onAccountSwitched;
  // final Function(String) updateAccountName;
  final Function reloadPage;



  ShowAccountWidget(this._companyUser, this.onAccountSwitched, this.reloadPage, {super.key})
      : _isVisible = List.generate(
          _companyUser.length,
          (index) => ValueNotifier<bool>(true),
        );
  @override
  _ShowAccountWidgetState createState() => _ShowAccountWidgetState();
}
class _ShowAccountWidgetState extends State<ShowAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._companyUser.length + 1,
      itemBuilder: (ctx, index) {
        if (index == widget._companyUser.length) {
          return const AddAccountWidget();
        } else {
          return InkWell(
            onTap: () {
              primaryFocus?.unfocus();
              setState(() {
                for (var account in widget._companyUser) {
                  account.isLogin = false;
                }
                widget._companyUser[index].isLogin = true;
              });
              widget.onAccountSwitched(widget._companyUser[index]);
              Navigator.of(context).pop();
              widget.reloadPage();
            },
            highlightColor: Colors.grey,
            child: ListTile(
              leading: Image.asset('assets/images/avatar_default_img.png'),
              title: Text(
                widget._companyUser[index].user.fullName,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                widget._companyUser[index].user.typeUser,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              trailing: widget._companyUser[index].isLogin
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
            ),
          );
        }
      },
    );
  }
}