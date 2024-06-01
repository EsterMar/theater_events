import 'dart:math';
import 'package:flutter/material.dart';
import 'package:theater_events/model/support/extensions/GlobalClient.dart';

import '../../model/objects/Biglietto.dart';
import '../../model/objects/Cliente.dart';
import '../../model/objects/Evento.dart';
import '../../model/support/ParamAddTicket.dart';
import '../widget/InputField.dart';
import '../widget/TicketCard.dart';
import '../../model/Model.dart';
import 'dart:convert';

class CustomerInfo extends StatefulWidget {
  final int numberOfTickets;
  final Evento evento;
  final List<int> availablePostIds;

  CustomerInfo({Key? key, required this.numberOfTickets, required this.evento, required this.availablePostIds}) : super(key: key);

  @override
  _CustomerInfoState createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  List<TextEditingController> controllers = [];
  List<Biglietto> biglietti = [];
  Cliente? clienteLoggato;

  @override
  void initState() {
    super.initState();
    print ("numero di biglietti richiesti: "+widget.numberOfTickets.toString());
    for (int i = 0; i < widget.numberOfTickets; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    Random random = Random();
    int ticketsCreated = 0;  // Contatore per il numero di biglietti creati
    ParamAddTicket? paramAddTicket;

    for (int i = 0; i < controllers.length; i++) {
      String name = controllers[i].text;
      bool created = false;

      while (!created && ticketsCreated < widget.numberOfTickets) {
        int randomIndex = random.nextInt(widget.availablePostIds.length);
        int postoId = widget.availablePostIds[randomIndex];

        paramAddTicket = ParamAddTicket(
          postoId: postoId,
          evento: widget.evento,
          cliente: clienteglobale,
          ticketPrice: widget.evento.spettacolo?.price,
          clientName: name,
        );


        try {
        var ticket = await Model.sharedInstance.addTicket(paramAddTicket);
        if (ticket.id != -1) {
          ticket.name = name;

          // Aggiungi l'ID del posto per confermare la posizione
          var posto = await Model.sharedInstance.seatById(postoId);
          if (posto != null) {
            ticket.posto = posto;
            biglietti.add(ticket);
            created = true;
            ticketsCreated++;
          } else {
            print('Errore: Impossibile trovare il posto con ID $postoId');
          }

      } else {
            print('Errore nella creazione del biglietto');
          }
        } catch (e) {
          print('Errore nella creazione del biglietto: $e');
        }

        // Rimuove l'ID del posto non disponibile dalla lista
        if (!created) {
          widget.availablePostIds.removeAt(randomIndex);
        }
      }

      if (!created) {
        // Gestisci il caso in cui non ci sono posti disponibili
        print('Non ci sono posti disponibili');
      }
    }

    if (paramAddTicket != null) {
      // Naviga alla pagina dei dettagli dei biglietti, passando i dati dei biglietti come parametro
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketCard(pat: paramAddTicket!, biglietti: biglietti),
        ),
      );
    } else {
      // Gestisci il caso in cui paramAddTicket è null
      print('Errore: ParamAddTicket è null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Inserisci i dati',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.numberOfTickets,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InputField(
                      labelText: "Nome e cognome del cliente ${index + 1}",
                      controller: controllers[index], // Usa il controller corrispondente
                      initialValue: '',
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _submit(context), // Passa il contesto corrente alla funzione _submit
              child: Text('Conferma'),
            ),
          ],
        ),
      ),
    );
  }
}
