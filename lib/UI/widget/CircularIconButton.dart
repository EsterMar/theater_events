import 'package:flutter/material.dart';



class CircularIconButton extends StatelessWidget {
  final IconData? icon;
  final void Function()? onPressed;

  const CircularIconButton({Key? key, this.icon, this.onPressed, required EdgeInsets padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: RawMaterialButton(
        onPressed: onPressed ?? () {}, // Se onPressed è null, usa una funzione vuota
        elevation: 2.0,
        fillColor: Colors.red,
        child: Icon(icon, color: Theme.of(context).backgroundColor),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    );
  }
}

