import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db_api/constants/constants.dart';

import '../models/searchmodel.dart';

class SearchAp {
  static final List<SearchModel> list = [];

  static Future<List<SearchModel>> fetchAllSearch(
      String query, bool flag, language) async {
    if (flag) {
      list.clear();
    }

    List<SearchModel> _list2 = [];

    final response = await http.get(Uri.parse(Constants.base +
        Constants.searchMulti +
        Constants.apiParam +
        Constants.apiKey +
        Constants.searchQueryParam +
        query +
        Constants.language +
        language));

    var dataDecoded = jsonDecode(response.body);
    var results = dataDecoded['results'];

    if (results is List) {
      _list2 = results.map((e) => SearchModel.fromJson(e)).toList();
      list.addAll(_list2);
    }
    return list;
  }

  static Future<SearchModel> fetchAllDetails(
      String id, String mediaType) async {
    final response = await http.get(Uri.parse(Constants.base +
        "$mediaType/" +
        id +
        Constants.apiParam +
        Constants.apiKey +
        "&append_to_response=images,videos,credits"));
    var dataDecoded = jsonDecode(response.body);
    return SearchModel.fromDetailsJson(dataDecoded);
  }
}
