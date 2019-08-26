class League {
  final int id;
  final String imageUrl;
  final String name;

  League({this.id, this.imageUrl, this.name});

    factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      imageUrl: json['image_url'],
      name: json['name'],
    );
  }
}