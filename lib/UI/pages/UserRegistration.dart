import 'package:theater_events/UI/behaviors/AppLocalizations.dart';
import 'package:theater_events/UI/widget/CircularIconButton.dart';
import 'package:theater_events/UI/widget/InputField.dart';
import 'package:theater_events/model/Model.dart';
import 'package:theater_events/model/objects/Cliente.dart';
import 'package:theater_events/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';


class UserRegistration extends StatefulWidget {
  UserRegistration({Key? key}) : super(key: key);


  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  bool _adding = false;
  Cliente? _justAddedUser;

  TextEditingController _firstNameFiledController = TextEditingController();
  TextEditingController _lastNameFiledController = TextEditingController();
  TextEditingController _telephoneNumberFiledController = TextEditingController();
  TextEditingController _emailFiledController = TextEditingController();
  TextEditingController _addressFiledController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                AppLocalizations.of(context).translate("register").capitalize + "!",
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  InputField(
                    labelText: AppLocalizations.of(context).translate("firstName").capitalize,
                    controller: _firstNameFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("lastName").capitalize,
                    controller: _lastNameFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("telephoneNumber").capitalize,
                    controller: _telephoneNumberFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("email").capitalize,
                    controller: _emailFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("address").capitalize,
                    controller: _addressFiledController, initialValue: '',
                  ),
                  CircularIconButton(
                    icon: Icons.person_rounded,
                    onPressed: () {
                      _register();
                    },
                    padding: EdgeInsets.zero,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _adding ?
                      CircularProgressIndicator() :
                      _justAddedUser != null ?
                      Text(
                          AppLocalizations.of(context).translate("just_added") + ":" + '${_justAddedUser?.name}' + " " + '${_justAddedUser?.surname}' + "!",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ):
                      SizedBox.shrink(),
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    setState(() {
      _adding = true;
      _justAddedUser = null;
    });
    Cliente user = Cliente(
      name: _firstNameFiledController.text,
      surname: _lastNameFiledController.text,
      telephone_number: _telephoneNumberFiledController.text,
      email: _emailFiledController.text,
      address: _addressFiledController.text,
    );
    Model.sharedInstance.addUser(user).then((result) {
      setState(() {
        _adding = false;
        _justAddedUser = result;
        print("Il cliente aggiunto è: $user");
      });
    });
  }


}
