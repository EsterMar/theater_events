import 'package:theater_events/UI/behaviors/AppLocalizations.dart';
import 'package:theater_events/model/Model.dart';
import 'package:theater_events/model/objects/Teatro.dart';
import 'package:theater_events/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';
import '../widget/ThaterCard.dart';


class SearchByCity extends StatefulWidget {
  final TextEditingController searchFieldController;

  SearchByCity({required this.searchFieldController, Key? key}) : super(key: key);

  @override
  _SearchByCityState createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {
  late TextEditingController _searchFieldController;
  List<Teatro>? _theaters;
  bool _searching = false;

  @override
  void initState() {
    super.initState();
    _searchFieldController = widget.searchFieldController;
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
            _searchFieldController.text.isNotEmpty
                ? "Risultati per la città ${_searchFieldController.text.capitalize}"
                : "Non esiste nessun teatro nella città ${_searchFieldController.text.capitalize}",
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
        ? _theaters == null || _theaters!.isEmpty
        ? SizedBox.shrink()
        : yesResults()
        : CircularProgressIndicator();
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _theaters!.length,
          itemBuilder: (context, index) {
            return TheaterCard(
              theater: _theaters![index],
            );
          },
        ),
      ),
    );
  }

  Widget noResults() {
    return Text(AppLocalizations.of(context).translate("no_results").capitalize + "!");
  }

  void _search() {
    setState(() {
      _searching = true;
      _theaters = null;
    });
    Model.sharedInstance.searchTheater(_searchFieldController.text).then((result) {
      setState(() {
        _searching = false;
        // Verifica che result non sia nullo prima di assegnarlo a _theaters
        _theaters = result ?? [];
      });
    });
  }
}

