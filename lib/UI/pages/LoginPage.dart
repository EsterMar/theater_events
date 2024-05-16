import 'package:flutter/material.dart';
import 'package:theater_events/UI/pages/UserRegistration.dart';

import '../widget/InputField.dart';
import 'keycloack_login_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,//non torno indietro automaticamente nella pagina Login
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            InputField(
            labelText: "Username",
            controller: _usernameController, initialValue: '',
            ),
              InputField(
                labelText: "Password",
                controller: _passwordController, initialValue: '',
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String username = _usernameController.text;
                  String clientSecret = _passwordController.text;
                  print("usarname: "+username + " password: "+clientSecret);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KeycloakLoginScreen(
                        username: username,
                        clientSecret: clientSecret,
                      ),
                    ),
                  );
                },
                child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.red,
                    )
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserRegistration()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.red,
                        )
                    ),
                    Icon(
                        Icons.arrow_forward,
                        color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
