class Movies {
  final String id;
  final int rank;
  final String title;
  final String fullTitle;
  final int year;
  final String image;
  final String crew;
  final double imDbRating;
  final int imDbRatingCount;

   Movies(
      {required this.id,
      required this.rank,
      required this.title,
      required this.fullTitle,
      required this.year,
      required this.image,
      required this.crew,
      required this.imDbRating,
      required this.imDbRatingCount});

  factory Movies.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final rank = int.parse(data['rank']);
    final title = data['title'] as String;
    final fullTitle = data['fullTitle'] as String;
    final year =int.parse(data['year']);
    final image = data['image'] as String;
    final crew = data['crew'] as String;
    final imDbRating = double.parse(data['imDbRating']);
    final imDbRatingCount =int.parse(data['imDbRatingCount']);
    return Movies(
        id: id,
        rank: rank,
        title: title,
        fullTitle: fullTitle,
        year: year,
        image: image,
        crew: crew,
        imDbRating: imDbRating,
        imDbRatingCount: imDbRatingCount);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rank'] = rank;
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
    String str =
        '{\n id:$id, \n rank:$rank,\n title:$title, \n fullTitle:$fullTitle ,\n year:$year\n crew:$crew,\n imDbRating:$imDbRating,\n imDbRatingCount:$imDbRatingCount\n}';
    return str;
  }
}
