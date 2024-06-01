import 'package:flutter/material.dart';
import 'package:theater_events/UI/pages/PayEvent.dart';
import '../../model/Model.dart';
import '../../model/objects/Evento.dart';
import '../../model/objects/Spettacolo.dart';
import 'package:intl/intl.dart';

class ShowDetails extends StatefulWidget {
  final Spettacolo show;

  ShowDetails({Key? key, required this.show}) : super(key: key);

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
            // Row per la freccia e il titolo dello spettacolo
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(), // Spazio flessibile per spingere il titolo al centro
                Text(
                  _show.title!,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(), // Spazio flessibile per bilanciare la riga
              ],
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
            'Plot: ',
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
            'Genre: ',
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
            'Events:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 5),
          _eventi != null
              ? _eventi!.isEmpty
              ? Text('No available event', style: TextStyle(color: Colors.white))
              : ListView.builder(
            shrinkWrap: true,
            itemCount: _eventi!.length,
            itemBuilder: (context, index) {
              final evento = _eventi![index];
              if (evento != null) {
                return ListTile(
                  subtitle: Text(
                    'Data: ${formatDate(evento.data ?? DateTime.now())}, Ore: ${evento.hours ?? 'Not available'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayEvent(evento: evento),
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
      print("Error during the rescue of the events: $error");
      setState(() {
        _loading = false;
      });
    });
  }

}

