import 'package:flutter/material.dart';
import '../../model/objects/Biglietto.dart';
import '../../model/support/ParamAddTicket.dart';
import '../pages/Home.dart';
import 'package:intl/intl.dart';

class TicketCard extends StatelessWidget {
  final ParamAddTicket pat;
  final List<Biglietto> biglietti;

  TicketCard({required this.pat, required this.biglietti});

  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Dettagli Biglietti',
          style: TextStyle(
          color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
              color: Colors.white
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()), // Naviga alla schermata home
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: biglietti.length,
        itemBuilder: (context, index) {
          var biglietto = biglietti[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pat.evento?.spettacolo?.title}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${biglietto.name}'),
                  Text('${pat.evento?.spettacolo?.teatro?.name}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Data: ${formatDate(pat.evento?.data ?? DateTime.now())}'),
                      Text('Ora: ${pat.evento?.hours}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sala: ${pat.evento?.posto?.sala}'),
                      Text('Posto: Fila ${biglietto.posto?.row}, Numero ${biglietto.posto?.seat}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Prezzo: ${pat.ticketPrice}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
