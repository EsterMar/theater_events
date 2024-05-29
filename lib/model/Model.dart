import 'dart:async';
import 'dart:convert';
import 'package:theater_events/model/managers/RestManager.dart';
import 'package:theater_events/model/objects/Cliente.dart';
import 'package:theater_events/model/objects/Evento.dart';
import 'package:theater_events/model/objects/Teatro.dart';
import 'package:theater_events/model/support/Constants.dart';
import 'package:theater_events/model/support/ParamAddTicket.dart';
import 'package:theater_events/model/support/authentication/AuthenticationData.dart';

import 'objects/Biglietto.dart';
import 'objects/Posto.dart';
import 'objects/Spettacolo.dart';


class Model {
  static Model sharedInstance = Model();

  final RestManager _restManager = RestManager();

  final String token="";

  final AuthenticationData authenticationData = AuthenticationData.getInstance();

  RestManager getRestMan() {
    return _restManager;
  }

  Future<List<Teatro>> searchTheater(String city) async {
    Map<String, String> params = Map();
    params["city"] = city;
    print("city: " + city);
    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
     // print("response: "+await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_THEATER, params).toString());
      final response = json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_THEATER, params)).map((i) => Teatro.fromJson(i)).toList();
      print("response: "+await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_THEATER, params));
      List<Teatro> theater = List<Teatro>.from(response);
      print(theater);
      return theater;
    } catch (e) {
      print("error in searchByCity: "+e.toString());
      return List<Teatro>.empty(); // Restituisci una lista vuota in caso di errore nella ricerca del teatro
    }
  }


  Future<List<Spettacolo>> searchShow(String titolo) async {
    Map<String, String> params = {'titolo': titolo};
    print("titolo: $titolo");

    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      final response = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_SEARCH_SHOW,
        params,
      );

      // Stampa la risposta ricevuta per il debug
      print("response: $response");

      // Decodifica la risposta JSON
      final List<dynamic> jsonList = json.decode(response);

      // Converte la lista di mappe JSON in una lista di oggetti Spettacolo
      List<Spettacolo> shows = jsonList.map((jsonItem) {
        return Spettacolo.fromJson(jsonItem as Map<String, dynamic>);
      }).toList();

      print("shows: $shows");
      return shows;
    } catch (e) {
      print("error in searchShow show: $e");
      return List<Spettacolo>.empty(); // Restituisci una lista vuota in caso di errore
    }
  }


  Future<List<Evento>> allEventsFromShow(String titolo) async {
    Map<String, String> params = {'title': titolo};
    print("titolo: $titolo");

    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      final response = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_LIST_EVENTS,
        params,
      );

      // Stampa la risposta ricevuta per il debug
      print("response: $response");

      // Decodifica la risposta JSON
      final List<dynamic> jsonList = json.decode(response);

      // Converte la lista di mappe JSON in una lista di oggetti Spettacolo
      List<Evento> events = jsonList.map((jsonItem) {
        return Evento.fromJson(jsonItem as Map<String, dynamic>);
      }).toList();

      print("events: $events");
      return events;
    } catch (e) {
      print("error in allEventsFromShow show: $e");
      return List<Evento>.empty(); // Restituisci una lista vuota in caso di errore
    }
  }

  Future<List<Spettacolo>> allShowsFromTheater(int id_teatro) async {
    Map<String, String> params = {'id_teatro': id_teatro.toString()};
    print("parametro teatro: $id_teatro");

    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      final response = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_LIST_SHOWS,
        params,
      );

      // Stampa la risposta ricevuta per il debug
      print("response: $response");

      // Decodifica la risposta JSON
      final List<dynamic> jsonList = json.decode(response);

      // Converte la lista di mappe JSON in una lista di oggetti Spettacolo
      List<Spettacolo> shows = jsonList.map((jsonItem) {
        return Spettacolo.fromJson(jsonItem as Map<String, dynamic>);
      }).toList();

      print("shows: $shows");
      return shows;
    } catch (e) {
      print("error in allShowFromTheater show: $e");
      return List<Spettacolo>.empty(); // Restituisci una lista vuota in caso di errore
    }
  }

  Future<List<int>> getAllFreeSeats(int id_sala) async {
    Map<String, String> params = {'id_sala': id_sala.toString()};
    print("id_sala: " + id_sala.toString());

    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      final response = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_FREE_SEATS,
        params,
      );

      // Stampa la risposta ricevuta per il debug
      print("response: $response");

      // Decodifica la risposta JSON
      final List<dynamic> jsonList = json.decode(response);

      // Assumi che jsonList sia una lista di interi e ne fa la conversione
      List<int> seatIds = jsonList.cast<int>();

      print("seatIds: $seatIds");
      return seatIds;
    } catch (e) {
      print("error in getAllFreeSeats show: $e");
      return List<int>.empty(); // Restituisci una lista vuota in caso di errore
    }
  }




  Future<int> allSeatsFromSala(int id_sala) async {
    Map<String, String> params = {'id_sala': id_sala.toString()};
    print("parametro sala: $id_sala");
    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      print("id_sala: " + id_sala.toString());

      String response = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_SEATS_NUMBER,
        params,
      );
      print("La response sarà: " + response);

      // Prova a decodificare la risposta come JSON
      try {
        Map<String, dynamic> jsonResponse = json.decode(response);
        print("La jsonResponse sarà: " + jsonResponse.toString());
        if (jsonResponse.containsKey('seatsNumber')) {
          int seatsNumber = jsonResponse['seatsNumber'];
          print("seats Number: " + seatsNumber.toString());
          return seatsNumber;
        } else {
          print("La risposta JSON non contiene 'seatsNumber'");
          return -1;
        }
      } catch (e) {
        // Se la decodifica JSON fallisce, prova a interpretare la risposta come un intero
        try {
          int seatsNumber = int.parse(response);
          print("seats Number: " + seatsNumber.toString());
          return seatsNumber;
        } catch (e) {
          print("Errore durante l'interpretazione della risposta come intero: " + e.toString());
          return -1;
        }
      }
    } catch (e) {
      print("Errore in allSeatsFromSala: " + e.toString());
      return -1;
    }
  }

  Future<Posto?> seatById(int id_posto) async {
    Map<String, String> params = {'id_posto': id_posto.toString()};
    print("id_posto: $id_posto");

    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      final response = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_SEATS_BY_ID,
        params,
      );

      // Stampa la risposta ricevuta per il debug
      print("response: $response");

      // Verifica se la risposta è vuota
      if (response == null || response.isEmpty) {
        print("Errore: la risposta è vuota");
        return null;
      }

      // Decodifica la risposta JSON in un oggetto Posto
      try {
        return Posto.fromJson(json.decode(response));
      } catch (e) {
        // Se si verifica un errore durante l'analisi della risposta JSON, restituisci null
        print("Errore durante l'interpretazione della risposta come oggetto Posto: $e");
        return null;
      }
    } catch (e) {
      // Se si verifica un errore durante la richiesta, restituisci null
      print("Errore durante la richiesta: $e");
      return null;
    }

  }




  Future<double> priceByTickets(int id_spettacolo, int chosenTickets) async {
    Map<String, String> params = {
      'id_spettacolo': '${id_spettacolo}',
      'numBiglietti': '${chosenTickets}'
    };
    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      String response = await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_PRICE_TICKETS,
          params
      );
      print("La response sarà: " + response);

      // Prova a interpretare la risposta come un numero
      try {
        double price = double.parse(response);
        print("Prezzo calcolato: " + price.toString());
        return price;
      } catch (e) {
        print("Errore durante l'interpretazione della risposta come numero: " + e.toString());
        return -1.0;
      }
    } catch (e) {
      print("Errore durante la richiesta: " + e.toString());
      return -1.0;
    }
  }

  Future<Cliente?> getByEmail(String email) async {
    Map<String, String> params = {'email': email};
    print("email: $email");

    try {
      _restManager.setToken(authenticationData.getAccessToken()!);
      final response = await _restManager.makeGetRequest(
        Constants.ADDRESS_STORE_SERVER,
        Constants.REQUEST_USER_BY_EMAIL,
        params,
      );

      // Stampa la risposta ricevuta per il debug
      print("response: $response");

      // Decodifica la risposta JSON in un oggetto Cliente
      try {
        // Se l'analisi della risposta JSON avviene con successo, restituisci un oggetto Cliente
        return Cliente.fromJson(json.decode(response));
      } catch (e) {
        // Se si verifica un errore durante l'analisi della risposta JSON, restituisci null
        print("Errore durante l'interpretazione della risposta come oggetto Cliente: $e");
        return null;
      }
    } catch (e) {
      // Se si verifica un errore durante la richiesta, restituisci null
      print("Errore durante la richiesta: $e");
      return null;
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
        _restManager.setToken(authenticationData.getAccessToken()!);
        String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_BUY_TICKET, pat);
        if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
          print(Constants.ADDRESS_STORE_SERVER+Constants.REQUEST_BUY_TICKET);
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
