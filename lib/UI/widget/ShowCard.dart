import 'package:flutter/material.dart';

import '../../model/objects/Spettacolo.dart';

import 'package:intl/intl.dart';

class ShowCard extends StatelessWidget {
  final Spettacolo? show;


  ShowCard({Key? key, this.show}) : super(key: key);

  //Per formattare il DateTime ed evitare di far uscie anche l'orario: "00:00:00"
  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              show!.title!,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.red,
              ),
            ),
            Text(
              '${formatDate(show!.first_day! ?? DateTime.now())}',
              style: const TextStyle(
                fontSize:14,
                color: Colors.red,
              ),
            ),
            Text(
               '${formatDate(show!.last_day! ?? DateTime.now())}',
              //show!.last_day!.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            /*Text(
              product!.description!,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),*/
          ],
        ),
      ),
    );
  }


}
