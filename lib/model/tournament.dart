class Tournament {
  final DateTime beginAt;
  final DateTime endAt;
  final int id;
  final int leagueId;
  final String name;

  Tournament({this.beginAt, this.endAt, this.id, this.leagueId, this.name});

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      beginAt: json['begin_at'] != null ? DateTime.tryParse(json['begin_at']) : null,
      endAt: json['end_at'] != null ? DateTime.tryParse(json['end_at']) : null,
      id: json['id'],
      leagueId: json['league_id'],
      name: json['name'],
    );
  }
}