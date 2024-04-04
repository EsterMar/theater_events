import 'dart:async';
import 'dart:convert';
import 'package:theater_events/model/managers/RestManager.dart';
import 'package:theater_events/model/objects/AuthenticationData.dart';
import 'package:theater_events/model/objects/Cliente.dart';
import 'package:theater_events/model/objects/Teatro.dart';
import 'package:theater_events/model/support/Constants.dart';
import 'package:theater_events/model/support/LogInResult.dart';
import 'package:theater_events/model/support/ParamAddTicket.dart';

import 'objects/Biglietto.dart';
import 'objects/Spettacolo.dart';


class Model {
  static Model sharedInstance = Model();

  final RestManager _restManager = RestManager();
  AuthenticationData _authenticationData= AuthenticationData();


  Future<LogInResult> logIn(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        if ( _authenticationData.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _authenticationData.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken!;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn ?? 0 - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken!;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken!;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = ' ';
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken!;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<List<Teatro>> searchTheater(String city) async {
    Map<String, String> params = Map();
    params["city"] = city;
    try {
      return List<Teatro>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_THEATER, params)).map((i) => Teatro.fromJson(i)).toList());
    }
    catch (e) {
      return List<Teatro>.empty(); // Restituisci una lista vuota in caso di errore nella ricerca del teatro
    }
  }


  Future<List<Spettacolo>> searchShow(String title) async {
    Map<String, String> params = Map();
    params["title"] = title;
    try {
      return List<Spettacolo>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_SHOW, params)).map((i) => Spettacolo.fromJson(i)).toList());
    }
    catch (e) {
      return List<Spettacolo>.empty(); // Restituisci una lista vuota in caso di errore nella ricerca del teatro
    }
  }



  Future<Cliente> addUser(Cliente user) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
      print("Il risultato è: " +rawResult);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return Cliente(id: -1); // sostituisce il valore null a causa della null-safety
      }
      else {
        return Cliente.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return Cliente(id: -1);
    }
  }


  Future<Biglietto> addTicket(ParamAddTicket pat) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_BUY_TICKET, pat);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return Biglietto(id: -1); // sostituisce il valore null a causa della null-safety
      }
      else {
        return Biglietto.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return Biglietto(id: -1);
    }
  }

}
