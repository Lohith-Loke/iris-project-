class Movies {
  final String? id;
  final String? rank;
  final String? rankUpDown;
  final String? title;
  final String? fullTitle;
  final String? year;
  final String? image;
  final String? crew;
  final String? imDbRating;
  final String? imDbRatingCount;

  Movies(
      {this.id,
      this.rank,
      this.rankUpDown,
      this.title,
      this.fullTitle,
      this.year,
      this.image,
      this.crew,
      this.imDbRating,
      this.imDbRatingCount});

  factory Movies.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final rank = json['rank'];
    final rankUpDown = json['rankUpDown'];
    final title = json['title'];
    final fullTitle = json['fullTitle'];
    final year = json['year'];
    final image = json['image'];
    final crew = json['crew'];
    final imDbRating = json['imDbRating'];
    final imDbRatingCount = json['imDbRatingCount'];
    return Movies(
      id: id,
      rank: rank,
      rankUpDown: rankUpDown,
      title: title,
      fullTitle: fullTitle,
      year: year,
      image: image,
      crew: crew,
      imDbRating: imDbRating,
      imDbRatingCount: imDbRatingCount,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rank'] = rank;
    data['rankUpDown'] = rankUpDown;
    data['title'] = title;
    data['fullTitle'] = fullTitle;
    data['year'] = year;
    data['image'] = image;
    data['crew'] = crew;
    data['imDbRating'] = imDbRating;
    data['imDbRatingCount'] = imDbRatingCount;
    return data;
  }

  @override
  String toString() {
    String str = """{id:$id,
      rank: $rank,
      rankUpDown: $rankUpDown,
      title: $title,
      fullTitle: $fullTitle,
      year: $year,
      image: $image,
      crew: $crew,
      imDbRating: $imDbRating,
      imDbRatingCount: $imDbRatingCount}""";
    return str;
  }
}
