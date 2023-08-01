import 'package:eands_movie_app/view/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/extra.dart';

class MovieGenresChips extends StatelessWidget {
  final List<int> genreIds;

  MovieGenresChips({
    required this.genreIds,
  });

  List<Map<String, dynamic>> getSelectedGenres() {
    return gen.where((genre) => genreIds.contains(genre['id'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: getSelectedGenres().map((genre) {
        return Chip(
          backgroundColor: mediumColorFF,
          side: BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          label: MyText(text: genre['name'], textColor: lightBlueColorE8),
        );
      }).toList(),
    );
  }
}
