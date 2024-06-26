import 'dart:convert';
import '../Constants.dart';


import 'package:http/http.dart' as http;

import 'AuthenticationData.dart';




class AccessTokenRequest {
  static Future<String?> getAccessToken() async {


    String grantType= "client_credentials";
    String clientId = "login-app";
    String clientSecret= "NWmFPUVLk9KVTMYhDEoTIba6oOVlUwlw";
    String urlToken = Constants.REQUEST_LOGIN;


    Map<String, String> headers = {
      'Authorization': 'Basic Ok5XbUZQVVZMazlLVlRNWWhERW9USWJhNm9PVmxVd2x3',
      'Content-Type':'application/x-www-form-urlencoded',
    };


    Map<String, String> requestBody = {
      "grant_type": grantType,
      "client_id": clientId,
      "client_secret": clientSecret,

    };

    final response = await http.post(Uri.parse(urlToken),
         headers: headers, body: requestBody);

    print("body: "+response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      AuthenticationData authenticationData = AuthenticationData.fromJson(
          jsonResponse);
      AuthenticationData.instance = authenticationData;
      print("authenticationData token accessToken: "+authenticationData.toString());
      return jsonResponse["access_token"];
    } else {
      print("Error response code: ${response.statusCode}");
      print("body: "+json.decode(response.body));
      return null;
    }
  }


}
