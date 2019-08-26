class Opponent {
  final String acronym;
  final int id;
  final String imageUrl;
  final String name;
  final String slug;

  Opponent({this.acronym, this.id, this.imageUrl, this.name, this.slug});

  factory Opponent.fromJson(Map<String, dynamic> json) {
    return Opponent(
      acronym: json['acronym'],
      id: json['id'],
      imageUrl: json['image_url'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}