import 'package:http/http.dart';
import 'dart:convert';
import 'package:week2Assignment/movie/moviecontroller.dart';
import 'package:week2Assignment/model/model.dart';

moviefetch() async {
  MovieController controller = MovieController();
  String url =
      "https://yts.mx/api/v2/list_movies.json?page=${controller.pageno}";
  Response response = await get(url);
  _responseDecoder(response.body);
}

_responseDecoder(String body) {
  Map<String, dynamic> movies = json.decode(body)["data"];

  List<dynamic> movielist = movies["movies"];
  for (var i = 0; i < movielist.length; i++) {
    print(movielist[i]);
    Map eachMovie = movielist[i];

    Model model = Model(
        name: eachMovie["title"],
        image: eachMovie['url'],
        released: eachMovie['year'],
        runtime: eachMovie['rating'],
        rating: eachMovie['runtime'],
        genres: eachMovie['genres']);
  }
}
