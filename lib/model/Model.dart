import 'dart:async';
import 'dart:convert';
import 'package:theater_events/model/managers/RestManager.dart';
import 'package:theater_events/model/managers/RestManager2.dart';
import 'package:theater_events/model/objects/Cliente.dart';
import 'package:theater_events/model/objects/Evento.dart';
import 'package:theater_events/model/objects/Teatro.dart';
import 'package:theater_events/model/support/Constants.dart';
import 'package:theater_events/model/support/ParamAddTicket.dart';

import 'objects/Biglietto.dart';
import 'objects/Sala.dart';
import 'objects/Spettacolo.dart';


class Model {
  static Model sharedInstance = Model();

  final RestManager _restManager = RestManager();
  final RestManager2 _restManager2 = RestManager2();

  /*String? getToken() {
    return _restManager.token;
  }*/

  RestManager getRestMan() {
    return _restManager;
  }

  Future<List<Teatro>> searchTheater(String city) async {
    Map<String, String> params = Map();
    params["city"] = city;
    print("city: " + city);
    try {
      final response = json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_THEATER, params)).map((i) => Teatro.fromJson(i)).toList();
      List<Teatro> theater = [];

      for (var json in response) {
        Teatro t = Teatro.fromJson(json);
        theater.add(t);
      }
      print(theater);
      return theater;
    } catch (e) {
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

    Future<List<Evento>> allEventsFromShow(Spettacolo show) async {
      Map<String, String> params = Map();
      params[show.title!] = show.title!;
      try {
        return List<Evento>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_LIST_EVENTS, params)).map((i) => Evento.fromJson(i)).toList());
      }
      catch (e) {
        return List<Evento>.empty(); // Restituisci una lista vuota in caso di errore nella ricerca del teatro
      }
    }

    Future<int> allSeatsFromSala(Sala id_sala) async {
      Map<String, String> params = {'${id_sala.room_number}': '${id_sala.room_number}'};
      try {
        String response = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEATS_NUMBER, params);
        Map<String, dynamic> jsonResponse = json.decode(response);
        print("La chiave sarà: "+response);
        int seatsNumber = jsonResponse['seatsNumber']; //da rivedere in seguito alla print
        return seatsNumber;
      } catch (e) {
        return -1;
      }
    }

    Future<double> priceByTickets(Evento evento) async {
      Map<String, String> params = {'${evento.id}': '${evento.id}'};
      try {
        String response = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRICE_TICKETS, params);
        print("La chiave sarà: "+response);
        Map<String, dynamic> jsonResponse = json.decode(response);
        double price = jsonResponse['price']; //da rivedere in seguito alla print
        return price;
      } catch (e) {
        return -1;
      }
    }

    Future<Cliente> addUser(Cliente user) async {
      try {
        print("Inizio addUser");
        String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
        print("Il risultato è: " +rawResult);
        if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
          print("Termino addUser");
          return Cliente(id: -1); // sostituisce il valore null a causa della null-safety
        }
        else {
          print("Termino addUser");
          print("risultato: "+Cliente.fromJson(jsonDecode(rawResult)).toString());
          return Cliente.fromJson(jsonDecode(rawResult));
        }
      }
      catch (e) {
        print("Termino addUser");
        print(e);
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


