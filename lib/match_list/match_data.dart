import 'package:flutter/material.dart';
import 'package:csgo_agenda/model/match.dart';
import 'package:intl/intl.dart';

class MatchData extends StatelessWidget {
  final Match match;

  MatchData(this.match);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _loadTeamImage(0),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(_getTeamName(0)),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'vs.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _loadTeamImage(1),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(_getTeamName(1)),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _getMatchDate(),
            )
          ],
        ),
      ],
    );
  }

  String _getTeamName(int position) {
    if (!match.opponents.isEmpty && match.opponents.length - 1 >= position) {
      return match.opponents[position].name;
    } else {
      return 'TBD';
    }
  }

  String _getMatchDate() {
    if(match.scheduledAt != null) {
      DateTime localDate = match.scheduledAt.toLocal();
      return DateFormat('dd-MM-yyyy hh:mm').format(localDate);
    }
    return 'TBD';
  }

  dynamic _loadTeamImage(int position) {
    if (!match.opponents.isEmpty && match.opponents.length - 1 >= position) {
      return Image.network(
        match.opponents[position].imageUrl,
        height: 50,
        width: 50,
      );
    } else {
      return Text(
        '?',
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      );
    }
  }
}
