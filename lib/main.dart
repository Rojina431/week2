import 'package:flutter/material.dart';
import 'package:week2Assignment/movie/movielist.dart';
import 'package:week2Assignment/movie/moviedetail.dart';

void main() {
  runApp(MaterialApp(
    title: 'Movie App',
    debugShowCheckedModeBanner: false,
    routes: {'/details': (context) => MovieDetailPage()},
    home: MovieList(),
  ));
}
