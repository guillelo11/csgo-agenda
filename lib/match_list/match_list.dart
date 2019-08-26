import 'package:csgo_agenda/match_list/match_element.dart';
import 'package:flutter/material.dart';
import 'package:csgo_agenda/model/match.dart';

class MatchList extends StatefulWidget {
  @override
  _MatchListState createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  Future<List<Match>> _matchList;

  @override
  void initState() {
    super.initState();
    _matchList = _matchList = Match.getUpcomingMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Match>>(
        future: _matchList,
        builder: (context, snaphot) {
          if (snaphot.hasData) {
            List<Match> matches = snaphot.data;
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return MatchElement(matches[index]);
              },
            );
          } else {
            return Text('No data yet');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
