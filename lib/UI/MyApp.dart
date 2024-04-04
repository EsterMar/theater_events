import 'package:theater_events/UI/behaviors/AppLocalizations.dart';
import 'package:theater_events/UI/pages/Layout.dart';
import 'package:theater_events/model/support/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      localizationsDelegates: const [//rivedere il const
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: Colors.indigo,
        backgroundColor: Colors.white,
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.lightBlueAccent,
            textTheme: ButtonTextTheme.primary,//capire senza di questo che succede
          )
        // buttonColor: Colors.lightBlueAccent,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.amberAccent,
        backgroundColor: Colors.black,
        canvasColor: Colors.black,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.amber,
          textTheme: ButtonTextTheme.primary,
        ),
        //buttonColor: Colors.amber,
        cardColor: Colors.grey[800],
      ),
      home: Layout(title: Constants.APP_NAME),
    );
  }


}
