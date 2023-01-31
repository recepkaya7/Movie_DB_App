import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db_api/constants/constants.dart';
import 'package:movie_db_api/models/tvmodel.dart';

class Tvapi {
  static final List<Tvmodel> list = [];
  static Future<List<Tvmodel>> fetchAllTv(int page, bool flag, String language,
      {String? path}) async {
    List<Tvmodel> _list2 = [];
    if (flag) {
      list.clear();
    }
    path ??= Constants.tvTopRated;
    final response = await http.get(
      Uri.parse(Constants.base +
          path +
          Constants.apiParam +
          Constants.apiKey +
          Constants.pageNumber +
          page.toString() +
          Constants.language +
          language),
    );
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
      _list2 = results.map((e) => Tvmodel.fromJson(e)).toList();
      list.addAll(_list2);
    }
    return list;
  }

  static Future<Tvmodel> fetchAllDetails(String id) async {
    final response = await http.get(Uri.parse(Constants.base +
        "tv/" +
        id +
        Constants.apiParam +
        Constants.apiKey +
        "&append_to_response=images,videos,credit"));
    var dataDecoded = jsonDecode(response.body);
    return Tvmodel.fromDetailsJson(dataDecoded);
  }
}
