import 'package:eands_movie_app/utils/colors.dart';
import 'package:eands_movie_app/view/widgets/posterimage_widget.dart';
import 'package:eands_movie_app/view/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/MovieDetailModel.dart';
import '../../provider/movie_api_provider.dart';
import '../widgets/genres_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
  });

  final double padd = 15;
  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;

    print(id);
    return Scaffold(
      body: Container(
        child: FutureBuilder<MovieDetail>(
          future: MovieApiProviderImpl().getMovieDetail(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              MovieDetail detail = snapshot.data;
              List<int> ids = [];
              detail.genreIds.forEach((element) {
                ids.add(element["id"]);
              });

              return Stack(
                children: [
                  MyPosterImage(
                      imageUrl: detail.backdropPath,
                      width: MediaQuery.of(context).size.width,
                      height: 400),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.black38),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 300,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: whiteColorFF),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: padd),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: MyText(
                                        text: detail.title,
                                        textColor: blackColor00,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.bookmark_border_outlined,
                                      size: 28,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: padd),
                                child: myRating(detail.voteAverage.toString()),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: padd),
                                child: MovieGenresChips(
                                  genreIds: ids ?? [],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: padd),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    textValues(
                                        "Release Date", detail.releaseDate),
                                    textValues(
                                        "Language",
                                        detail
                                            .spokenLanguages.first.englishName),
                                    textValues("Rating", "PG-13"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: padd),
                                child: MyText(
                                  text: "Description",
                                  textColor: blackColor00,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              MyText(text: "${detail.overview}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 38, 38, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.keyboard_backspace_outlined,
                            color: whiteColorFF,
                            size: 25,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.ellipsis,
                          color: whiteColorFF,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _launchUrl(detail.homepage),
                          child: Icon(
                            Icons.play_circle,
                            size: 55,
                            color: whiteColorFF,
                          ),
                        ),
                        MyText(
                          text: "Play Trailer",
                          textColor: whiteColorFF,
                          fontSize: 35,
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri(path: url))) {
      throw Exception('Could not launch $url');
    }
  }

  Widget textValues(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText(text: title),
          MyText(
            text: value,
            textColor: blackColor00,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          )
        ],
      ),
    );
  }

  Widget myRating(String rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        MyText(text: "$rating/10 IMDb"),
      ],
    );
  }
}
