import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_db_api/pages/search_details.dart';

import '../constants/constants.dart';
import '../constants/style_constants.dart';
import '../models/searchmodel.dart';

class SearchHome extends StatefulWidget {
  final SearchModel searchmodel;
  final int index;

  const SearchHome({
    Key? key,
    required this.index,
    required this.searchmodel,
  }) : super(key: key);

  @override
  State<SearchHome> createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  bool isLiked = false;
  int likeCount = 17;
  int sayac = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.searchmodel.backdropPath != null) {
      return SizedBox(
        height: 120,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchDetails(
                  searchmodel: widget.searchmodel,
                ),
              ),
            );
          },
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(56),
                topLeft: Radius.circular(56),
                bottomRight: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            color: Colors.blueGrey.shade900,
            shadowColor: Colors.black54,
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 100,
                    child: CachedNetworkImage(
                      imageUrl: Constants.imageBase +
                          widget.searchmodel.backdropPath.toString(),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:
                                widget.searchmodel.title.toString().length > 20
                                    ? marqueeMethod(widget.searchmodel)
                                    : Text(
                                        widget.searchmodel.title.toString(),
                                        style: Sabitler.baslikStyle,
                                      ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                     Text(
                                      "Media Type".tr,
                                      style: Sabitler.yilStyle,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      widget.searchmodel.mediaType.toString().tr,
                                      style: Sabitler.yilStyle,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                     Text(
                                      "Vote".tr,
                                      style: Sabitler.yilStyle,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      widget.searchmodel.voteAverage.toString(),
                                      style: Sabitler.yilStyle,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    FavoriteButton(
                                      isFavorite: false,
                                      valueChanged: () {},
                                    )
                                    /* Text(
                                      searchmodel.releaseDate!.year.toString(),
                                      style: Sabitler.yilStyle,
                                    ), */
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else
      // ignore: curly_braces_in_flow_control_structures
      return const Center();
  }

  Marquee marqueeMethod(SearchModel searchmodel) {
    return Marquee(
      text: searchmodel.title.toString(),
      style: Sabitler.baslikStyle,
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: const Duration(seconds: 1),
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }
}
