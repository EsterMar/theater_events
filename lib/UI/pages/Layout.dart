import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../behaviors/AppLocalizations.dart';
import 'Home.dart';
import 'LoginPage.dart';

class Layout extends StatefulWidget {
  final String? title;


  Layout({Key? key, this.title}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState(title);
}

class _LayoutState extends State<Layout> {
  late String? title;


  _LayoutState(String? title) {
    this.title = title;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title!,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: RenderErrorBox.backgroundColor,
          toolbarHeight: 80,
          actions: [
            IconButton(
            onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );},
              icon: const Padding(
                padding: EdgeInsets.only(right: 20.0),
               child: Icon(
                 Icons.accessibility_rounded,
                 color: Colors.black,
               ),

           ),
          ),
          ],//actions
          bottom: TabBar(
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(
             icon: const Icon(Icons.home_rounded, color: Colors.white),
                  child: Text (
                     AppLocalizations.of(context).translate("home").toUpperCase(),
                     style: const TextStyle(color: Colors.white)
              )
            )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Home(),

          ],
        ),
        ),
    );
  }
}
