import 'package:flutter/material.dart';

import '../../model/objects/Spettacolo.dart';


class ShowCard extends StatelessWidget {
  final Spettacolo? product;


  ShowCard({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              product!.title!,
              style: const TextStyle(
                fontSize: 40,
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
