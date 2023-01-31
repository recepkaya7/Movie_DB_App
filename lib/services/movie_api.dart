import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db_api/constants/constants.dart';
import 'package:movie_db_api/models/moviemodel.dart';

class MovieApi {
  static final List<Moviemodel> list = [];

  static Future<List<Moviemodel>> fetchAllMovies(
      int page, bool flag, String language,
      {String? path}) async {
    if (flag) {
      list.clear();
    }

    List<Moviemodel> _list2 = [];
    path ??= Constants.nowPlaying;
    final response = await http.get(Uri.parse(Constants.base +
        path +
        Constants.apiParam +
        Constants.apiKey +
        Constants.pageNumber +
        page.toString() +
        Constants.language +
        language));
    print(Constants.base +
        path +
        Constants.apiParam +
        Constants.apiKey +
        Constants.pageNumber +
        page.toString() +
        Constants.language +
        language);

    var dataDecoded = jsonDecode(response.body);
    var results = dataDecoded['results'];

    if (results is List) {
      _list2 = results.map((e) => Moviemodel.fromJson(e)).toList();
      list.addAll(_list2);
    }
    return list;
  }

  static Future<Moviemodel> fetchAllDetails(String id) async {
    final response = await http.get(Uri.parse(Constants.base +
        "movie/" +
        id +
        Constants.apiParam +
        Constants.apiKey +
        "&append_to_response=images,videos,credits"));
    var dataDecoded = jsonDecode(response.body);
    return Moviemodel.fromDetailsJson(dataDecoded);
  }
}
