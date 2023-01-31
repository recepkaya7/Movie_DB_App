import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static final String base = dotenv.env["API_URL"]!;
  static final String imageBase = dotenv.env["IMAGE_URL"]!;
  static final String apiKey = dotenv.env["API_KEY"]!;
  static const String popularMovies = "movie/popular";
  static const String apiParam = "?api_key=";
  static const String youtubePlayer = "movie/29776/videos";
  static const String searchMulti = "search/multi";
  static const String searchQueryParam = "&query=";
  static const String language = "&language=";
  static const String tvPopuler = "tv/popular";
  static const String pageNumber = "&page=";
  static const String upComing = "movie/upcoming";
  static const String nowPlaying = "movie/now_playing";
  static const String topRated = "movie/top_rated";
  static const String onTheAir = "tv/on_the_air";
  static const String tvTopRated = "tv/top_rated";
  static const Color kPrimaryColor = Color(0xFF6F35A5);
  static const Color kProfilColor = Color.fromARGB(255, 23, 67, 111);
  static const Color kPrimaryLightColor = Color(0xFFF1E6FF);
}
