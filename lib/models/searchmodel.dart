import 'dart:convert';

import 'package:movie_db_api/constants/constants.dart';

SearchModel moviemodelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String moviemodelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
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
    this.mediaType
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
  String? mediaType;

  factory SearchModel.fromDetailsJson(Map<String, dynamic> json) {
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
    return SearchModel(
      images: paths,
      videos: video,
      genresName: paths2,
    );
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      adult: json["adult"],
      mediaType: json["media_type"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"] != null
          ? List<int>.from(json["genre_ids"].map((x) => x))
          : [23],
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"] ?? json['original_name'],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      //releaseDate: DateTime.parse(json["release_date"]),
      title: json["title"] ?? json['name'],
      video: json["video"],
      voteAverage:
          json["vote_average"] != null ? json["vote_average"].toDouble() : 0.0,
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "media_type": mediaType,
      "backdrop_path": backdropPath,
      "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
      "id": id,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      /* "release_date":
          "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}", */
      "title": title,
      "video": video,
      "videos": videos ?? "gelmedi",
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
  }
}
