import 'package:theater_events/UI/behaviors/AppLocalizations.dart';
import 'package:theater_events/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/objects/Cliente.dart';
import '../../model/objects/Spettacolo.dart';
import '../widget/CircularIconButton.dart';
import 'SearchByCity.dart';
import 'ShowDetails.dart';


class Home extends StatefulWidget {
  final Cliente? cliente;

  const Home({Key? key, required this.cliente}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _searchByCity = TextEditingController();
  TextEditingController _searchByName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        // Larghezza desiderata per la barra di ricerca
                        width: 700,
                        //Preferisco TextField a InputField, in questo caso, perché dà più colore e rimpie di più la pagina.
                        child: TextField(
                          controller: _searchByCity,
                          decoration: InputDecoration(
                            hintText: "Search theater by city",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(width: 0), // Spazio tra il campo di ricerca e il pulsante
                  CircularIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () {
                      String city= _searchByCity.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchByCity(city: city, cliente: widget.cliente!)),
                      );
                    },
                    padding: EdgeInsets.zero,
                  ),
                  //  ],
                  //),

                  SizedBox(height: 10),
                  //Row(
                  // children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 300,
                        // Larghezza desiderata per la barra di ricerca
                        child: TextField(
                          controller: _searchByName,
                          decoration: InputDecoration(
                            hintText: "Search show by name",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(width: 2), // Spazio tra il campo di ricerca e il pulsante

                  /*CircularIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () {
                      String name= _searchByName.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchByName(name: name)),
                      );
                    },
                    padding: EdgeInsets.zero,
                  ),*/

                  CircularIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () {
                      String name = _searchByName.text;
                      print("name: "+name);
                      _searchAndNavigate(context, name);
                    },
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),

              SizedBox(height: 3),
              const Image (image: AssetImage(
                  "C:/Users/Ester/IdeaProjects/theater_events/lib/images/sipario-project.jpg"),
                width: 10000, // larghezza desiderata
                height: 400, // altezza desiderata
              ),

              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations
                          .of(context)
                          .translate("welcome")
                          .capitalize,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                  ], //children
                ),

              ),
            ],
          ),

        ),
      ),
    );
  }

  void _searchAndNavigate(BuildContext context, String name) async {
    print("inizio searchAndNavigate");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    List<Spettacolo>? shows = await Model.sharedInstance.searchShow(name);
    print("shows: "+shows.toString());
    // Nasconde l'indicatore progress
    Navigator.of(context).pop();

    // Se lo show esiste, naviga in ShowDetails, altrimenti mostra un messaggio di errore
    if (shows != null && shows.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowDetails(show: shows.first, cliente: widget.cliente!),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Errore"),
          content: Text("Non esiste nessuno spettacolo con il titolo $name!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}

