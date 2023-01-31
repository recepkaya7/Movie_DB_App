import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/constants.dart';
import 'package:movie_db_api/constants/style_constants.dart';
import 'package:movie_db_api/models/tvmodel.dart';
import 'package:movie_db_api/services/tv_api.dart';
import 'package:movie_db_api/widgets/photos_show_dialog.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvDetails extends StatefulWidget {
  final Tvmodel tvmodel;
  const TvDetails({Key? key, required this.tvmodel}) : super(key: key);

  @override
  State<TvDetails> createState() => _TvDetailsState();
}

class _TvDetailsState extends State<TvDetails> {
  late Tvmodel tv = widget.tvmodel;
  late YoutubePlayerController _controller;

  late Future<Tvmodel> _tvDetailsFuture;

  set rating(double rating) {}

  @override
  void initState() {
    super.initState();
    _tvDetailsFuture = Tvapi.fetchAllDetails(tv.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: moviePlayerB4(),
    );
  }

  double get width => MediaQuery.of(context).size.width;

  FutureBuilder<Tvmodel> moviePlayerB4() {
    return FutureBuilder<Tvmodel>(
      future: _tvDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Tvmodel oankiTv = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showDialogMethod(
                        context, oankiTv, newMethod(oankiTv.videos.toString()));
                  },
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.none,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.elliptical(width / 2, width / 12),
                              bottomRight:
                                  Radius.elliptical(width / 2, width / 12),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  oankiTv.images!.first.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/play2.png",
                          height: 100,
                          width: 100,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform:
                      Matrix4.translationValues(0, -width * 9 / 16 * .2, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 120,
                              height: 120 * 16 / 9,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                      offset: Offset(0, 7.0)),
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                image: DecorationImage(
                                  image: NetworkImage(Constants.imageBase +
                                      tv.posterPath.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: width * 9 / 16 * .2 + 16,
                              ),
                              Text(
                                tv.name.toString(),
                                style: Sabitler.baslikStyle,
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                children: [
                                  Text(tv.voteAverage.toString(),
                                      style: Sabitler.voteStyle),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  ratingBar()
                                ],
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Ratings: ".tr,
                                    style: Sabitler.ratingsGradeStyle,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Grade Now".tr,
                                    style: Sabitler.ratingsGradeStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14.0,
                              ),
                              rowMethod("Popularity: ".tr,
                                  tv.popularity!.toDouble().toStringAsFixed(2)),
                              const SizedBox(
                                height: 9.0,
                              ),
                              rowMethod(
                                  "Genres:".tr, oankiTv.genresName!.join(", ")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "OverView".tr,
                        style: Sabitler.baslikStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      readMore(),
                    ],
                  ),
                ),
                const Divider(
                  height: 32,
                  thickness: 2,
                  indent: 16,
                  color: Colors.white30,
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Photos".tr,
                    style: Sabitler.baslikStyle,
                  ),
                ),
                SizedBox(
                  height: (width / 5) + 32,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8.0);
                    },
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: oankiTv.images!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return photosShowDialog(context, oankiTv, index);
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ReadMoreText readMore() {
    return ReadMoreText(
      tv.overview.toString(),
      trimLines: 3,
      textAlign: TextAlign.justify,
      trimMode: TrimMode.Line,
      trimCollapsedText: "Readmore".tr,
      trimExpandedText: "Readless".tr,
      lessStyle: Sabitler.showStyle,
      moreStyle: Sabitler.showStyle,
      style: Sabitler.storyStyle,
    );
  }

  RatingBar ratingBar() {
    return RatingBar.builder(
      allowHalfRating: true,
      unratedColor: Colors.blueGrey.shade200,
      itemCount: 10,
      initialRating: tv.voteAverage!.toDouble(),
      itemSize: 18,
      ignoreGestures: false,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.green,
      ),
      onRatingUpdate: (rating) => setState(() {
        this.rating = rating;
      }),
    );
  }

  Row rowMethod(String s1, String s2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s1,
          style: Sabitler.yilStyle,
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            s2,
            style: Sabitler.yilStyle,
          ),
        ),
      ],
    );
  }

  Future<dynamic> showDialogMethod(
      BuildContext context, Tvmodel oankiFilm, dynamic fullScreen) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AspectRatio(
        aspectRatio: 16 / 9,
        child: AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.all(10),
            backgroundColor: Colors.transparent,
            content: fullScreen),
      ),
      barrierDismissible: true,
    );
  }

  YoutubePlayer newMethod(String youtubeid) {
    _controller = YoutubePlayerController(
        initialVideoId: youtubeid,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false));

    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
    );
  }
}
