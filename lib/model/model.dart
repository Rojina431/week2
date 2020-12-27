import 'dart:ffi';

class Model {
  int id;
  String name;
  String image;
  int released;
  int runtime;
  double rating;
  String desc;
  String size;
  List<dynamic> genres;

  Model(
      {this.id,
      this.name,
      this.image,
      this.released,
      this.runtime,
      this.rating,
      this.desc,
      this.size,
      this.genres});
}
