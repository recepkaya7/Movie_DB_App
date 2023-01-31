import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_db_api/constants/constants.dart';
import 'package:movie_db_api/constants/style_constants.dart';
import 'package:movie_db_api/models/moviemodel.dart';
import 'package:movie_db_api/pages/movie_details.dart';

class MovieHome extends StatelessWidget {
  final Moviemodel moviemodel;
  final int index;

  const MovieHome({Key? key, required this.moviemodel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (moviemodel.backdropPath != null) {
      return SizedBox(
        height: 120,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetails(
                  moviemodel: moviemodel,
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
                          moviemodel.backdropPath.toString(),
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
                            child: moviemodel.title.toString().length > 20
                                ? marqueeMethod(moviemodel)
                                : Text(
                                    moviemodel.title.toString(),
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
                                      moviemodel.releaseDate!.year.toString(),
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
                                      moviemodel.originalLanguage.toString(),
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
                                      moviemodel.voteAverage.toString(),
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
      // ignore: curly_braces_in_flow_control_structures
      return const Center();
  }

  Marquee marqueeMethod(Moviemodel moviemodel) {
    return Marquee(
      text: moviemodel.title.toString(),
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
