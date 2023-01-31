import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_db_api/constants/constants.dart';
import 'package:movie_db_api/constants/style_constants.dart';
import 'package:movie_db_api/models/tvmodel.dart';
import 'package:movie_db_api/pages/tv_details.dart';

class TvHome extends StatelessWidget {
  final Tvmodel tvmodel;
  final int index;

  const TvHome({Key? key, required this.tvmodel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tvmodel.backdropPath != null) {
      return SizedBox(
        height: 120,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TvDetails(
                  tvmodel: tvmodel,
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
                      imageUrl:
                          Constants.imageBase + tvmodel.backdropPath.toString(),
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
                            child: tvmodel.name.toString().length > 20
                                ? marqueeMethod(tvmodel)
                                : Text(
                                    tvmodel.name.toString(),
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
                                      "Release Date".tr,
                                      style: Sabitler.yilStyle,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      tvmodel.firstAirDate!.year.toString(),
                                      style: Sabitler.yilStyle,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                     Text(
                                      "Language".tr,
                                      style: Sabitler.yilStyle,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      tvmodel.originalLanguage.toString(),
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
                                      tvmodel.voteAverage.toString(),
                                      style: Sabitler.yilStyle,
                                    ),
                                  ],
                                )
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
      return Center();
  }

  Marquee marqueeMethod(Tvmodel tvmodel) {
    return Marquee(
      text: tvmodel.name.toString(),
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
