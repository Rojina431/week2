import 'package:flutter/material.dart';
import 'package:week2Assignment/model/model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int pageno = 1;
  List<Widget> _listItems = List();
  bool _isLoading = false;
  double height, width;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviefetch(pageno);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie App"),
          backgroundColor: Color(0xff885566),
          //actions: [_refreshButton()],
        ),
        body: Column(children: [
          _isLoading == true ? LinearProgressIndicator() : SizedBox(),
          _myList(),
          _btn()
        ]));
  }

  Widget _btn() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          pageno = pageno + 1;
          moviefetch(pageno);
        });
      },
      child: Text('Load more'),
    );
  }

  moviefetch(int pageno) async {
    _enableLoading();
    String url =
        // ignore: unnecessary_brace_in_string_interps
        "https://yts.mx/api/v2/list_movies.json?page=${pageno}";
    Response response = await get(url);
    _responseDecoder(response.body);
    _disableLoading();
  }

  _enableLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  _disableLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  _responseDecoder(String body) {
    Map<String, dynamic> movies = json.decode(body)["data"];
    List<Widget> tempList = List();
    List<dynamic> movielist = movies["movies"];
    for (var i = 0; i < movielist.length; i++) {
      Map eachMovie = movielist[i];
      print(eachMovie);
      Model model = Model(
          id: eachMovie["id"],
          name: eachMovie["title"],
          image: eachMovie["background_image"],
          released: eachMovie['year'],
          runtime: (eachMovie['runtime']),
          rating: (eachMovie['rating']).toDouble(),
          desc: eachMovie['description_full'],
          size: eachMovie['size'],
          genres: eachMovie['genres']);

      Widget movieList = _cards(model);
      tempList = [...tempList, movieList].toSet().toList();
    }
    _listItems = tempList;
    setState(() {});
  }

  Widget _myList() {
    return SizedBox(
        height: height * .75,
        width: width,
        child: ListView(
          children: _listItems,
        ));
  }

  Widget _cards(Model model) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: model);
      },
      child: Card(
        color: Color(0xffffff),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  model.name,
                  style: TextStyle(color: Color(0xff885566)),
                )),
            Text((model.released).toString()),
            Image.network(model.image)
          ],
        ),
      ),
    );
  }
}
