class Serie {
  final DateTime beginAt;
  final String description;
  final DateTime endAt;
  final String fullName;
  final int id;
  final int leagueId;
  final String name;
  final int year;

  Serie({this.beginAt, this.description, this.endAt, this.fullName, this.id, this.leagueId, this.name, this.year});

    factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      beginAt: json['begin_at'] != null ? DateTime.tryParse(json['begin_at']) : null,
      description: json['description'],
      endAt: json['end_at'] != null ? DateTime.tryParse(json['end_at']) : null,
      fullName: json['full_name'],
      id: json['id'],
      leagueId: json['league_id'],
      name: json['name'],
      year: json['year'],
    );
  }
}