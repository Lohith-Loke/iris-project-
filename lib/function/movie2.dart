class Movieview {
  String? fullTitle;
  String? imDbRating;
  Ratings? ratings;
  String? contentRating;
  String? runtimeMins;
  String? plot;
  String? languages;
  String? directors;
  String? stars;
  String? awards;
  Posters2? posters2;

  Movieview(
      {this.fullTitle,
      this.imDbRating,
      this.ratings,
      this.contentRating,
      this.runtimeMins,
      this.plot,
      this.languages,
      this.directors,
      this.stars,
      this.awards,
      this.posters2});

  Movieview.fromJson(Map<String, dynamic> json) {
    fullTitle = json['fullTitle'];
    imDbRating = json['imDbRating'];
    ratings =
        json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
    contentRating = json['contentRating'];
    runtimeMins = json['runtimeMins'];
    plot = json['plot'];
    languages = json['languages'];
    directors = json['directors'];
    stars = json['stars'];
    awards = json['awards'];
    posters2 =
        json['posters'] != null ? Posters2.fromJson(json['posters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullTitle'] = fullTitle;
    data['imDbRating'] = imDbRating;
    if (ratings != null) {
      data['ratings'] = ratings!.toJson();
    }
    data['contentRating'] = contentRating;
    data['runtimeMins'] = runtimeMins;
    data['plot'] = plot;
    data['languages'] = languages;
    data['directors'] = directors;
    data['stars'] = stars;
    data['awards'] = awards;
    if (posters2 != null) {
      data['posters'] = posters2!.toJson();
    }
    return data;
  }
}

class Ratings {
  String? rottenTomatoes;

  Ratings({this.rottenTomatoes});

  Ratings.fromJson(Map<String, dynamic> json) {
    rottenTomatoes = json['rottenTomatoes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rottenTomatoes'] = rottenTomatoes;
    return data;
  }
}

class Posters2 {
  List<Posters>? posters;

  Posters2({this.posters});

  Posters2.fromJson(Map<String, dynamic> json) {
    if (json['posters'] != null) {
      posters = <Posters>[];
      json['posters'].forEach((v) {
        posters!.add(Posters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posters != null) {
      data['posters'] = posters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posters {
  String? id;
  String? link;
  double? aspectRatio;
  String? language;
  int? width;
  int? height;

  Posters(
      {this.id,
      this.link,
      this.aspectRatio,
      this.language,
      this.width,
      this.height});

  Posters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    aspectRatio = json['aspectRatio'];
    language = json['language'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['aspectRatio'] = aspectRatio;
    data['language'] = language;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
