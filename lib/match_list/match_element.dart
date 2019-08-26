import 'package:csgo_agenda/db_helper.dart';
import 'package:csgo_agenda/match_list/match_data.dart';
import 'package:flutter/material.dart';
import 'package:csgo_agenda/model/match.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchElement extends StatefulWidget {
  final Match match;
  final DbHelper dbHelper = DbHelper.instance;

  MatchElement(this.match);

  @override
  _MatchElementState createState() => _MatchElementState();
}

class _MatchElementState extends State<MatchElement> {
  bool _fav;

  @override
  void initState() {
    super.initState();
    _fav = widget.match.fav;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                  '${widget.match.league.name}: ${widget.match.serie.name}'),
              subtitle: Text(widget.match.tournament.name),
            ),
            MatchData(widget.match),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.tv),
                    tooltip: 'Watch',
                    onPressed:
                        widget.match.liveUrl != null ? _openStream : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite,
                        color: _fav ? Colors.red : Colors.black),
                    tooltip: 'Favorite',
                    onPressed: _favSwitch,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _favSwitch() async {
    setState(() {
      _fav = !_fav;
      int matchId = widget.match.id;
      String scheduledAt = widget.match.scheduledAt.toString();
      if(_fav) {
        widget.dbHelper.insert({'match_id': matchId, 'start_date': scheduledAt});
      } else {
        widget.dbHelper.delete(matchId);
      }
      
    });
  }

  _openStream() async {
    if (await canLaunch(widget.match.liveUrl)) {
      await launch(widget.match.liveUrl);
    }
  }
}
