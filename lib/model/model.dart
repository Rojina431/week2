import 'dart:ffi';

class Model {
  String name;
  String image;
  int released;
  double runtime;
  int rating;
  List<dynamic> genres;

  Model(
      {this.name,
      this.image,
      this.released,
      this.runtime,
      this.rating,
      this.genres});
}
