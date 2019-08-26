import 'package:csgo_agenda/db_helper.dart';
import 'package:csgo_agenda/model/league.dart';
import 'package:csgo_agenda/model/opponent.dart';
import 'package:csgo_agenda/model/serie.dart';
import 'package:csgo_agenda/model/tournament.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Match {
  final int id;
  final DateTime beginAt;
  final String name;
  final DateTime scheduledAt;
  final int numberOfGames;
  final List<Opponent> opponents;
  final String status;
  final Tournament tournament;
  final Serie serie;
  final League league;
  final String liveUrl;
  final bool fav;

  Match(
      {this.id,
      this.beginAt,
      this.name,
      this.scheduledAt,
      this.numberOfGames,
      this.opponents,
      this.status,
      this.tournament,
      this.serie,
      this.league,
      this.liveUrl,
      this.fav});

  factory Match.fromJson(Map<String, dynamic> json, favList) {
    bool markedFav = false;

    for (final f in favList) {
      if (f['match_id'] == json['id']) {
        markedFav = true;
      }
    }

    List<Opponent> opponentsList = List();

    for (final op in json['opponents']) {
      Opponent opponent = Opponent.fromJson(op['opponent']);
      opponentsList.add(opponent);
    }

    return Match(
      id: json['id'],
      beginAt:
          json['begin_at'] != null ? DateTime.tryParse(json['begin_at']) : null,
      name: json['name'],
      scheduledAt: json['scheduled_at'] != null
          ? DateTime.tryParse(json['scheduled_at'])
          : null,
      numberOfGames: json['number_of_games'],
      status: json['status'],
      opponents: opponentsList,
      tournament: Tournament.fromJson(json['tournament']),
      serie: Serie.fromJson(json['serie']),
      league: League.fromJson(json['league']),
      liveUrl: json['live_url'],
      fav: markedFav,
    );
  }

  static Future<List<Match>> getUpcomingMatches() async {
    List<Match> matchList = List();
    final String properties =
        await rootBundle.loadString('assets/properties.json');

    final propertiesJson = json.decode(properties);

    final String apiKey = propertiesJson['pandascore_api_key'];

    final response = await http.get(
        'https://api.pandascore.co/csgo/matches/upcoming?token=$apiKey');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final favorites = await DbHelper.instance.queryFavorites();
      for (final value in jsonResponse) {
        Match match = Match.fromJson(value, favorites);
        matchList.add(match);
      }
    } else {
      throw Exception('Failed to load post');
    }
    /* final String response =
        await rootBundle.loadString('assets/api_response_full.json');
    final jsonResponse = json.decode(response);

    final favorites = await DbHelper.instance.queryFavorites();

    for (final value in jsonResponse) {
      Match match = Match.fromJson(value, favorites);
      matchList.add(match);
    } */

    return matchList;
  }
}
