/*import 'package:theater_events/model/Model.dart';

import 'package:flutter/material.dart';

import '../../model/objects/Spettacolo.dart';
import '../widget/ShowCard.dart';
import 'ShowDetails.dart';


class SearchByName extends StatefulWidget {
  final String name;

  SearchByName({required this.name, Key? key}) : super(key: key);


  @override
  _SearchByNameState createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName> {
  bool _searching = false;
  List<Spettacolo>? _shows= List.empty();
  late String _name;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _search(); // Avvia la ricerca quando la pagina viene inizializzata
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            top(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget top() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            _shows != null && _shows!.isNotEmpty
                ? "Risultati per ${_name}:"
                : "Non esiste nessuno spettacolo con il titolo ${_name}!",
                style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
                ),
              ],
      )
    );
  }

  Widget bottom() {
    return  !_searching
      ? _shows == null
         ? SizedBox.shrink() :
    _shows!.isEmpty ?
        noResults() :
        yesResults() :
    CircularProgressIndicator();
  }

  Widget noResults() {
    return Text("No_results!",
        style: TextStyle( color: Colors.white)
    );
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _shows?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
              // Naviga verso la pagina dei dettagli passando il prodotto selezionato
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDetails(show: _shows![index]),
                ),
              );
            },
            child: SizedBox(
              height: 200,
              child: ShowCard(
                show: _shows![index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _search() {
    setState(() {
      _searching = true;
      _shows = null;
    });
    Model.sharedInstance.searchShow(_name).then((result) {
      setState(() {
        _searching = false;
        // Verifica che result non sia nullo prima di assegnarlo a _theaters
        _shows = result ?? [];
      });
    });
  }

}*/



