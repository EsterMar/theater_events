import 'package:flutter/material.dart';
import 'package:theater_events/UI/pages/PayEvent.dart';

import '../../model/Model.dart';
import '../../model/objects/Cliente.dart';
import '../../model/objects/Evento.dart';
import '../../model/objects/Spettacolo.dart';
import 'package:intl/intl.dart';

class ShowDetails extends StatefulWidget {
  final Spettacolo show;
  final Cliente cliente;

  ShowDetails({Key? key, required this.show, required this.cliente}) : super(key: key);

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  List<Evento>? _eventi = List.empty(); // Lista degli eventi associati allo spettacolo
  late Spettacolo _show;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _show = widget.show;
    // Chiamata al backend per ottenere gli eventi associati allo spettacolo
    fetchEventi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              top(),
              bottom(),
            ],
          ),
        ),
      )
    );
  }

  Widget top() {
    return Padding(
        padding: EdgeInsets.all(10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:10),
              Text(
                _show.title!,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10), // Spazio tra il testo e l'immagine
              // Immagine
              Container(
                width: 400, // Larghezza desiderata dell'immagine
                height: 400, // Altezza desiderata dell'immagine
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(getImagePth(_show.title!)),
                    // Inserisci il percorso dell'immagine
                    fit: BoxFit.cover, // Modalità di adattamento dell'immagine
                  ),

                ),
              ),
            ],
          ),
    );
  }

  String getImagePth(String title) {
    return "C:/Users/Ester/Desktop/Piattaforme/esercitazion/$title.jpg";
  }

  //Per formattare il DateTime ed evitare di far uscie anche l'orario: "00:00:00"
  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Widget bottom() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trama: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 5),
          Text(
            _show.description!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Genere: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          //SizedBox(height: 5),
          Text(
            _show.genre!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          // Eventi associati allo spettacolo
          Text(
            'Eventi:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 5),
          _eventi != null
              ? _eventi!.isEmpty
              ? Text('Nessun evento disponibile', style: TextStyle(color: Colors.white))
              : ListView.builder(
            shrinkWrap: true,
            itemCount: _eventi!.length,
            itemBuilder: (context, index) {
              final evento = _eventi![index];
              if (evento != null) {
                return ListTile(
                  subtitle: Text(
                    'Data: ${formatDate(evento.data ?? DateTime.now())}, Ore: ${evento.hours ?? 'Orario non disponibile'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayEvent(evento: evento, cliente: widget.cliente),
                      ),
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          )
              : CircularProgressIndicator(), // Indicatori di caricamento se la lista è null
        ],
      ),
    );
  }


  void fetchEventi() {
    Model.sharedInstance.allEventsFromShow(widget.show.title!).then((
        List<Evento> result) {
      setState(() {
        _eventi = result;
        _loading = false;
      });
    }).catchError((error) {
      // Gestire eventuali errori qui
      print("Errore durante il recupero degli eventi: $error");
      setState(() {
        _loading = false;
      });
    });
  }

}

