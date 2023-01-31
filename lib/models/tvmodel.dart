import 'dart:convert';

import 'package:movie_db_api/constants/constants.dart';

Tvmodel tvmodelFromJson(String str) => Tvmodel.fromJson(json.decode(str));

String tvmodelToJson(Tvmodel data) => json.encode(data.toJson());

class Tvmodel {
  Tvmodel({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.genresName,
    this.images,
    this.videos,
    this.video,
  });

  String? backdropPath;
  DateTime? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;
  List? genresName;
  List<String>? images;
  String? videos;
  String? video;

  factory Tvmodel.fromDetailsJson(Map<String, dynamic> json) {
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
    return Tvmodel(
      images: paths,
      videos: video,
      genresName: paths2,
    );
  }

  factory Tvmodel.fromJson(Map<String, dynamic> json) => Tvmodel(
        backdropPath: json["backdrop_path"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "name": name,
        "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
