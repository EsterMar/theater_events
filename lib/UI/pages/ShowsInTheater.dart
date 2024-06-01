import 'package:theater_events/model/Model.dart';
import 'package:flutter/material.dart';
import '../../model/objects/Spettacolo.dart';
import '../widget/ShowCard.dart';
import 'ShowDetails.dart';

class ShowsInTheater extends StatefulWidget {
  final int theaterId;

  ShowsInTheater({required this.theaterId, Key? key}) : super(key: key);

  @override
  _ShowsInTheaterState createState() => _ShowsInTheaterState();
}

class _ShowsInTheaterState extends State<ShowsInTheater> {
  bool _searching = false;
  List<Spettacolo>? _shows = List.empty();
  late int _theaterId;


  @override
  void initState() {
    super.initState();
    _theaterId = widget.theaterId;
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
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // Spazio per separare l'icona dal testo
          SizedBox(width: 10),
          Text(
            _shows != null && _shows!.isNotEmpty
                ? "Available shows:"
                : "There arent't available show for this theater!",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return !_searching
        ? _shows == null
        ? SizedBox.shrink()
        : _shows!.isEmpty
        ? noResults()
        : yesResults()
        : CircularProgressIndicator();
  }

  Widget noResults() {
    return Text("No result!",
        style: TextStyle(color: Colors.white));
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _shows?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Naviga verso la pagina dei dettagli passando lo spettacolo selezionato
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
    Model.sharedInstance.allShowsFromTheater(_theaterId).then((result) {
      setState(() {
        _searching = false;
        // Verifica che result non sia nullo prima di assegnarlo a _shows
        _shows = result ?? [];
      });
    });
  }
}
