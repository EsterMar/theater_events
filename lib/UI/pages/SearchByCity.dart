import 'package:flutter/material.dart';
import 'package:theater_events/model/Model.dart';
import '../../model/objects/Teatro.dart';
import '../widget/ThaterCard.dart';
import 'ShowsInTheater.dart';

class SearchByCity extends StatefulWidget {
  final String city;

  SearchByCity({required this.city, Key? key}) : super(key: key);

  @override
  _SearchByCityState createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {
  late String _city;
  List<Teatro>? _theaters = List.empty();
  bool _searching = false;
  int _currentPage = 0;
  String _sortBy = 'id';
  int _pageSize = 3;
  bool _hasMoreTheaters = true;

  @override
  void initState() {
    super.initState();
    _city = widget.city;
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
            paginationControls(),
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
          // Aggiungi l'icona della freccia per tornare indietro
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // Spazio per separare l'icona dal testo
          SizedBox(width: 10),
          Text(
            _theaters != null && _theaters!.isNotEmpty
                ? "Result for the city ${_city}:"
                : "Doesn't exist any theater in the city ${_city}!",
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
        ? _theaters == null
        ? SizedBox.shrink()
        : _theaters!.isEmpty
        ? noResults()
        : yesResults()
        : CircularProgressIndicator();
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _theaters?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Naviga verso la pagina dei dettagli passando il prodotto selezionato
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShowsInTheater(theaterId: _theaters![index].id!),
                  ),
                );
              },
              child: SizedBox(
                height: 200, // regola l'altezza
                child: TheaterCard(
                  theater: _theaters![index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget noResults() {
    return Text("No_results!",
        style: TextStyle(color: Colors.white));
  }

  Widget paginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _currentPage > 0
              ? () {
            setState(() {
              _currentPage--;
              _search();
            });
          }
              : null,
        ),
        Text(
          "Page ${_currentPage + 1}",
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: _hasMoreTheaters
              ? () {
            setState(() {
              _currentPage++;
              _search();
            });
          }
              : null,
        ),
      ],
    );
  }

  void _search() {
    setState(() {
      _searching = true;
    });
    Model.sharedInstance
        .searchTheater(_city, _currentPage, _pageSize, _sortBy)
        .then((result) {
      setState(() {
        _searching = false;
        _theaters = result ?? [];
        _hasMoreTheaters = _theaters!.length == _pageSize;
      });
    });
  }
}
