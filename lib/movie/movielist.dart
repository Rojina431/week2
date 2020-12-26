import 'package:flutter/material.dart';
import 'package:week2Assignment/movie/moviefetch.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie App"),
          backgroundColor: Color(0xff885566),
        ),
        body: IconButton(
          onPressed: () {
            moviefetch();
          },
          icon: Icon(Icons.show_chart),
        ));
  }
}
