import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/objects/Evento.dart';

class PayEvent extends StatefulWidget {
  final Evento evento;

  PayEvent({Key? key, required this.evento}) : super(key: key);

  @override
  _PayEventState createState() => _PayEventState();
}

class _PayEventState extends State<PayEvent> {
  int numberOfTickets = 0;
  int chosenTickets = 1;// Inizialmente un biglietto
  double totalPrice = 12.0; // Prezzo totale iniziale


  @override
  void initState() {
    super.initState();
    // Recupera il numero di posti nella sala
    print("sala: "+widget.evento.sala!.toString());
    Model.sharedInstance.allSeatsFromSala(widget.evento.sala!.room_number!).then((seatsNumber) {
      setState(() {
        numberOfTickets = seatsNumber;
        print('number Of Tickets: '+numberOfTickets.toString());
      });
    }).catchError((e) {
      print("Errore durante il recupero del numero di posti nella sala: $e");
    });
  }

  String getImagePth(String title) {
    return "C:/Users/Ester/Desktop/Piattaforme/esercitazion/$title.jpg";
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80.0, // Imposta l'altezza dell'app bar
        backgroundColor: Colors.black,
        iconTheme:IconThemeData(color: Colors.white),
        title: Text(
          'Acquista biglietto per ${widget.evento.spettacolo?.title}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40
          ),
        ),
      ),
      body: Stack(
        children: [
          // Immagine di sfondo
           Container(
            decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(getImagePth('${widget.evento.spettacolo?.title}')), // Assicurati che l'immagine sia nella cartella assets
                fit: BoxFit.cover, // Copri l'intero schermo
            ),
          ),
        ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Numero biglietti per: ${widget.evento.spettacolo?.title}',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.red
                )
            ),
            SizedBox(height: 40),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                   decoration: BoxDecoration(
                   color: Colors.white, // Colore di sfondo bianco
                     borderRadius: BorderRadius.circular(8.0), // Bordo arrotondato per il quadratino
                    ),
                width: 40, // Larghezza del quadratino
                height: 40,
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                    if (chosenTickets > 1) {
                        chosenTickets--;
                      // Calcolo del prezzo totale in base al numero di biglietti
                      Model.sharedInstance.priceByTickets(widget.evento.spettacolo!.id!,chosenTickets).then((totalePrice) {
                        setState(() {
                          totalPrice = totalePrice;
                          print("total price remove: "+totalPrice.toString());
                        }) ;
                    }).catchError((e) {
                        print("Errore durante il calcolo del prezzo: $e");
                      });
                      }
                    });
                  },
                 ),
                 ),
                Text(
                  '$chosenTickets',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red
                  ),
                ),
                SizedBox(width: 18), // Spazio tra i due quadratini
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Colore di sfondo bianco
                    borderRadius: BorderRadius.circular(8.0), // Bordo arrotondato per il quadratino
                  ),
                  width: 40, // Larghezza del quadratino
                  height: 40, // Altezza del quadratino
                  child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (numberOfTickets >0) {
                        chosenTickets++;
                        // Calcolo del prezzo totale in base al numero di biglietti
                        Model.sharedInstance.priceByTickets(widget.evento.spettacolo!.id!,chosenTickets).then((totalePrice) {
                          setState(() {
                            totalPrice = totalePrice;
                            print("total Price add: "+totalPrice.toString());
                          });
                        }).catchError((e) {
                          print("Errore durante il calcolo del prezzo: $e");
                        });
                      }
                    });
                  },
                ),
                ),
              ],
        ),
                SizedBox(height: 60),
                Text(
                  'Prezzo totale: €$totalPrice',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
