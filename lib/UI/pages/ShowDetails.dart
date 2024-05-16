import 'package:flutter/material.dart';
import 'package:theater_events/UI/pages/PayEvent.dart';

import '../../model/Model.dart';
import '../../model/objects/Evento.dart';
import '../../model/objects/Spettacolo.dart';

class ShowDetails extends StatefulWidget {
  final Spettacolo show;

  ShowDetails({Key? key, required this.show}) : super(key: key);

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  List<Evento> _eventi = []; // Lista degli eventi associati allo spettacolo

  @override
  void initState() {
    super.initState();
    // Chiamata al backend per ottenere gli eventi associati allo spettacolo
    fetchEventi();
  }

  void fetchEventi() {
    // Chiamata al backend per ottenere gli eventi associati allo spettacolo
    Model.sharedInstance.allEventsFromShow(widget.show).then((List<Evento> result) {
      setState(() {
        _eventi = result;
      });
    }).catchError((error) {
      // Gestire eventuali errori qui
      print("Errore durante il recupero degli eventi: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettagli dello spettacolo'),
      ),
      body: ListView.builder(
        itemCount: _eventi.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Naviga verso la pagina di dettagli dell'evento quando viene selezionato
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayEvent(evento: _eventi[index]),
                ),
              );
            },
            child: ListTile(
              title: Text(_eventi[index].spettacolo as String),
              // Personalizza ulteriormente il layout dell'elemento della lista se necessario
            ),
          );
        },
      ),
    );
  }
}


