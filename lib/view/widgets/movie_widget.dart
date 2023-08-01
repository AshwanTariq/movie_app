import 'package:eands_movie_app/view/widgets/posterimage_widget.dart';
import 'package:eands_movie_app/view/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'genres_widget.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.rating,
      required this.isPopular,
      this.genres});
  final String imageUrl;
  final String title;
  final String rating;
  final bool isPopular;
  final List<int>? genres;
  @override
  Widget build(BuildContext context) {
    if (isPopular) {
      return Container(
        child: Row(
          children: [
            MyPosterImage(
              width: 100,
              height: 170,
              imageUrl: imageUrl,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText(),
                    myRating(),
                    MovieGenresChips(
                      genreIds: genres ?? [],
                    ),
                    const Chip(
                        side: BorderSide(color: Colors.transparent),
                        shape: StadiumBorder(side: BorderSide.none),
                        avatar: Icon(Icons.access_time),
                        label: MyText(
                          text: "1h 47m",
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 15),
              child: MyPosterImage(
                width: 180,
                height: 250,
                imageUrl: imageUrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 5),
              child: myText(),
            ),
            myRating()
          ],
        ),
      );
    }
  }

  Widget myRating() {
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

  Widget myText() {
    return MyText(
      text: title,
      textColor: blackColor00,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
