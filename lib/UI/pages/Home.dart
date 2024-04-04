import 'package:theater_events/UI/behaviors/AppLocalizations.dart';
import 'package:theater_events/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import '../widget/CircularIconButton.dart';
import 'SearchByCity.dart';
import 'SearchByName.dart';


class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _searchFiledController = TextEditingController();

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
                        width: 200,
                        // Larghezza desiderata per la barra di ricerca
                        child: TextField(
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
                  const SizedBox(width: 0), // Spazio tra il campo di ricerca e il pulsante
                  CircularIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchByCity(searchFieldController: _searchFiledController)),
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
                  CircularIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchByName()),
                      );
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

}
