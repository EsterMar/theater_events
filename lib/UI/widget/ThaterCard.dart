import 'package:theater_events/model/objects/Teatro.dart';
import 'package:flutter/material.dart';


class TheaterCard extends StatelessWidget {
  final Teatro? theater;


  TheaterCard({Key? key, this.theater}) : super(key: key);

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
              theater!.name!,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.red,
              ),
            ),
            Text(
              theater!.city!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              theater!.address!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              theater!.telephone_number!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
