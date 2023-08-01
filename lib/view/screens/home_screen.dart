import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../widgets/movies_list_widget.dart';
import '../widgets/popular_movie.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              prefWidget("Now Showing"),
              MoviesList(),
              prefWidget("Popular"),
              PopMoviesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget prefWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: text,
          textColor: blackColor00,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                50), // Customize the corner radius as needed
          ),
          label: MyText(text: "See More"),
        ),
      ],
    );
  }

  AppBar myAppBar() {
    return AppBar(
      toolbarHeight: 56,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      centerTitle: true,
      title: MyText(
        text: 'FilmKu',
        textColor: blackColor00,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
