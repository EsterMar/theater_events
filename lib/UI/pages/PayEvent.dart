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
  int chosenTickets=1;// Inizialmente un biglietto
  double totalPrice = 0.0; // Prezzo totale iniziale

  @override
  void initState() {
    super.initState();
    // Recupera il numero di posti nella sala
    Model.sharedInstance.allSeatsFromSala(widget.evento.sala!).then((seatsNumber) {
      setState(() {
        numberOfTickets = seatsNumber;
      });
    }).catchError((e) {
      print("Errore durante il recupero del numero di posti nella sala: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acquista biglietto per ${widget.evento.spettacolo?.title}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome evento: ${widget.evento.spettacolo?.title}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      chosenTickets--;
                      // Calcolo del prezzo totale in base al numero di biglietti
                      Model.sharedInstance.priceByTickets(widget.evento).then((totalePrice) {
                        setState(() {
                          totalPrice = totalePrice;
                        });
                      }).catchError((e) {
                        print("Errore durante il calcolo del prezzo: $e");
                      });
                    });
                  },
                ),
                Text(
                  '$numberOfTickets',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (numberOfTickets >0) {
                        chosenTickets++;
                        // Calcolo del prezzo totale in base al numero di biglietti
                        Model.sharedInstance.priceByTickets(widget.evento).then((totalePrice) {
                          setState(() {
                            totalPrice = totalePrice;
                          });
                        }).catchError((e) {
                          print("Errore durante il calcolo del prezzo: $e");
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
