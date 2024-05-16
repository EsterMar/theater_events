import 'dart:async';

import 'package:flutter/material.dart';
import 'package:theater_events/model/support/authentication/setToken.dart';

import '../../model/support/authentication/AuthenticationData.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'Home.dart';
import 'LoginPage.dart';


class KeycloakLoginScreen extends StatefulWidget {
  final String username;
  final String clientSecret;

  KeycloakLoginScreen({required this.username, required this.clientSecret});





  @override
  _KeycloakLoginScreenState createState() => _KeycloakLoginScreenState();
}

class _KeycloakLoginScreenState extends State<KeycloakLoginScreen> {
  String? accessToken;
  bool isLoading = true;
  late Timer timer;


  @override
  void initState() {
    super.initState();
    login();
    startTimer();
    print('Username: ${widget.username}');
    print('Client Secret: ${widget.clientSecret}');
  }

  void startTimer() {
    timer = Timer(Duration(seconds: 30), () {
      if (isLoading) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Invalid Credentials'),
                content: Text('The login credentials are not valid.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); //torno alla schermata precedente
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      }
    });
  }

  Future<void> login() async {
    SetToken.username = widget.username;
    SetToken.clientSecret = widget.clientSecret;

    accessToken = await SetToken.setToken();

    if (accessToken != null) {
      final decodedToken = JwtDecoder.decode(accessToken!);
      setState(() {
        isLoading = false;
      });
      print("isLoading: "+isLoading.toString());
      //_navigateToLoginPage(context);
      _navigateToHomePage(context);
    } else {
      // Gestione degli errori di login
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Login Failed'),
              content: Text('An error occurred during the login process.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Naviga alla pagina di login quando il processo di caricamento è completo
   // if (!isLoading) {
   //   _navigateToLoginPage(context);
   // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Keycloak Login'),
      ),
      body: Center(
        child: CircularProgressIndicator(), // Mostra un indicatore di caricamento
      ),
    );
  }

  /*void _navigateToLoginPage(BuildContext context) {
    SetToken.username = '';
    SetToken.clientSecret = '';
    AuthenticationData.instance?.reset();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }*/
  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(), // Sostituisci 'HomePage()' con il nome della tua pagina home
      ),
    );
  }


}




