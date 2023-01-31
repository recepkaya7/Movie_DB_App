import 'dart:convert';

import 'package:movie_db_api/constants/constants.dart';

Moviemodel moviemodelFromJson(String str) =>
    Moviemodel.fromJson(json.decode(str));

String moviemodelToJson(Moviemodel data) => json.encode(data.toJson());

class Moviemodel {
  Moviemodel({
    this.images,
    this.genres,
    this.genresName,
    this.videos,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  List? genresName;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  List<String>? images;
  String? videos;
  List<String>? genres;

  factory Moviemodel.fromDetailsJson(Map<String, dynamic> json) {
    List genresName = json["genres"];
    List<String> paths2 = [];
    List images = json["images"]["backdrops"];
    List<String> paths = [];
    String video = json["videos"]["results"][0]["key"];
    images = images.take(10).toList();
    for (var value in images) {
      String path = Constants.imageBase.toString() + value["file_path"];
      paths.add(path);
    }
    for (var value in genresName) {
      String path1 = value["name"];
      paths2.add(path1);
    }
    return Moviemodel(
      images: paths,
      videos: video,
      genresName: paths2,
    );
  }

  factory Moviemodel.fromJson(Map<String, dynamic> json) => Moviemodel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "videos": videos ?? "gelmedi",
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
