import 'package:flutter/material.dart';
import 'match_list/match_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS:GO Agenda',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('CS:GO Agenda'),
        ),
        body: MatchList(),
      )
    );
  }
}