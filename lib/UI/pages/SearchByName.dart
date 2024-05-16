import 'package:theater_events/UI/behaviors/AppLocalizations.dart';
import 'package:theater_events/model/Model.dart';
import 'package:theater_events/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import '../../model/objects/Spettacolo.dart';
import '../widget/CircularIconButton.dart';
import '../widget/InputField.dart';
import '../widget/ShowCard.dart';
import 'ShowDetails.dart';


class SearchByName extends StatefulWidget {
  final String name;

  const SearchByName({required this.name, Key? key}) : super(key: key);


  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchByName> {
  bool _searching = false;
  List<Spettacolo>? _shows;

  TextEditingController _searchFiledController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          Flexible(
            child: InputField(
              labelText: AppLocalizations.of(context).translate("search").capitalize,
              controller: _searchFiledController,
              onSubmit: (value) {
                _search();
              }, initialValue: '',
            ),
          ),
          CircularIconButton(
            icon: Icons.search_rounded,
            onPressed: () {
              _search();
            }, padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return  !_searching ?
    _shows == null ?
    const SizedBox.shrink() :
    _shows?.length == 0 ?
    noResults() :
    yesResults() :
    CircularProgressIndicator();

  }

  Widget noResults() {
    return Text(AppLocalizations.of(context).translate("no_results").capitalize + "!");
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
            child: ShowCard(
            product: _shows![index],
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
    Model.sharedInstance.searchShow(_searchFiledController.text).then((result) {
      setState(() {
        _searching = false;
        _shows = result;
      });
    });
  }
}
