import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Constants.dart';

class KeycloakUserCreation {
  final String firstName;
  final String lastName;
  final String password;
  final String username;

  String userCreationUrl = "http://localhost:8080/admin/realms/SpringBootKeycloak/users";


  KeycloakUserCreation({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.username,
  });

  Future<bool> createUserInKeycloak(String accessToken) async {
    Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "enabled": true,
      "credentials": [
        {
          "type": "password",
          "value": password,
          "temporary": false,
        }
      ],
      "email": username,
      "groups": ["users"],
    };

    print("Il kuc è: "+requestBody.toString());


    final response = await http.post(
      Uri.parse(userCreationUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: json.encode(requestBody),
    );

    print("body della request: "+json.encode(requestBody));
    print("response richiesta add su Keycloak: ${response.body}");

    if (response.statusCode == 201) {
      print("User created successfully");
      return true;
    } else {
      print("Error response code: ${response.statusCode}");
      return false;
    }
  }

}
