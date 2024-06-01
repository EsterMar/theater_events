import 'dart:convert';
import 'dart:io';

import 'package:theater_events/model/objects/Cliente.dart';

import '../Constants.dart';
import 'AuthenticationData.dart';
import 'package:http/http.dart' as http;

Cliente currentClient= Cliente.empty();

class SetToken {
  static String username = '';
  static String clientSecret = '';




  static Future<String?> setToken() async {
    Map<String, String> headers = {
      'Authorization': 'Basic Ok5XbUZQVVZMazlLVlRNWWhERW9USWJhNm9PVmxVd2x3',
      'Content-Type':'application/x-www-form-urlencoded',
    };

    /*String contentType = "application/x-www-form-urlencoded";
    Map<String, String> headers = Map();
    headers[HttpHeaders.contentTypeHeader] = contentType;*/

    print("Headers: "+headers.toString());

    final Uri tokenEndpoint = Uri.parse(Constants.REQUEST_LOGIN);
    //print("token EndPoint: "+tokenEndpoint.toString());

    Map<String, String> body = {
      'grant_type': "client_credentials",
      'client_id': Constants.CLIENT_ID,
      'username': username,
      'password': clientSecret,
    };

    print("body in setToken: "+body.toString());

    final response = await http.post(tokenEndpoint, headers: headers, body: body);
    print("response richiesta login su Keycloak: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      //print("jsonResponse: "+jsonResponse.toString());
      AuthenticationData authenticationData = AuthenticationData.fromJson(
          jsonResponse);
      //print("AuthenticationData: "+authenticationData.accessToken.toString());
      AuthenticationData.instance =
          authenticationData; // Assegna l'istanza a AuthenticationData.instance


    } else {
            print("Doensn't work");
            print("Error response code: ${response.statusCode}");
    }
    print("Restituiamo il token di AuthenticationData");
    return AuthenticationData.getInstance().getAccessToken();
  }
}