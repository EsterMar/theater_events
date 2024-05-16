import 'package:theater_events/UI/widget/InputField.dart';
import 'package:theater_events/model/Model.dart';
import 'package:theater_events/model/objects/Cliente.dart';
import 'package:flutter/material.dart';
import '../../model/managers/RestManager.dart';
import '../../model/support/authentication/accessToken.dart';
import '../../model/support/authentication/KeycloakUserCreation.dart';
import 'LoginPage.dart';


class UserRegistration extends StatefulWidget {
  UserRegistration({Key? key}) : super(key: key);


  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  bool _adding = false;
  late Cliente? _justAddedUser;

  TextEditingController _firstNameFiledController = TextEditingController();
  TextEditingController _lastNameFiledController = TextEditingController();
  TextEditingController _telephoneNumberFiledController = TextEditingController();
  TextEditingController _emailFiledController = TextEditingController();
  TextEditingController _addressFiledController = TextEditingController();
  TextEditingController _passwordFiledController = TextEditingController();

  late String accessToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  InputField(
                    labelText: "FirstName",
                    controller: _firstNameFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: "LastName",
                    controller: _lastNameFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: "TelephoneNumber",
                    controller: _telephoneNumberFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: "Email",
                    controller: _emailFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: "Address",
                    controller: _addressFiledController, initialValue: '',
                  ),
                  InputField(
                    labelText: "Password",
                    controller: _passwordFiledController, initialValue: '',
                  ),


                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      final String firstName=_firstNameFiledController.text;
                      final String lastName=_lastNameFiledController.text;
                      final String password=_passwordFiledController.text;
                      final String username=_emailFiledController.text;




                      accessToken = (await AccessTokenRequest.getAccessToken())!;
                      print("token: "+accessToken.toString());

                      _register(accessToken);
                      if (accessToken != null) {
                        KeycloakUserCreation kuc = KeycloakUserCreation(firstName: firstName, lastName: lastName, password: password, username: username);
                        print("kuc: "+kuc.toString());
                        bool success = await kuc.createUserInKeycloak(accessToken);
                        print("success: "+success.toString());

                        if (success) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Success'),
                                content: Text('User created successfully.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Reindirizza alla pagina di login
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Email already used/Fill all fields '),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to obtain access token'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.red,
                        )
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


  //da capire se va modificato
  void _register(String accessToken) async {
    try {
      Cliente user = Cliente(
        name: _firstNameFiledController.text,
        surname: _lastNameFiledController.text,
        telephone_number: _telephoneNumberFiledController.text,
        email: _emailFiledController.text,
        address: _addressFiledController.text,
      );
      print("Cliente: "+user.toString());
      RestManager rm= Model.sharedInstance.getRestMan();
      rm.setToken(accessToken);
      await Model.sharedInstance.addUser(user);
    } catch (e) {
      print('Errore durante l\'aggiunta dell\'utente: $e');
    }
  }
}
