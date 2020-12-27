import 'package:flutter/material.dart';
import 'package:week2Assignment/model/model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MovieDetailPage extends StatefulWidget {
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  List<Widget> _actorList = List();
  double height, width;
  Model model;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    Model model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        backgroundColor: Color(0xff885566),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Card(
        child: Column(
          children: [
            _card(model),
            _table(model),
            _myList(),
            _btn(model),
          ],
        ),
      ),
    );
  }

  Widget _card(Model model) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: (model.desc).length <= 150
              ? Text(model.desc)
              : Text((model.desc).substring(0, 150)),
        )
      ],
    );
  }

  Widget _table(Model model) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Table(
        border: TableBorder.all(width: 2.0, color: Colors.grey),
        children: [
          TableRow(children: [
            TableCell(
                child: Row(
              children: [
                Text("Rating"),
              ],
            )),
            TableCell(
                child: Row(
              children: [
                Text("Runtime"),
              ],
            )),
            TableCell(
                child: Row(
              children: [
                Text("Download Size"),
              ],
            )),
          ]),
          TableRow(children: [
            TableCell(
                child: Row(
              children: [Text(model.rating.toString())],
            )),
            TableCell(
                child: Row(
              children: [Text(model.runtime.toString())],
            )),
            TableCell(
                child: Row(
              children: [Text(model.size != null ? model.size : "Not known")],
            )),
          ])
        ],
      ),
    );
  }

  Widget _btn(Model model) {
    return RaisedButton(
      onPressed: () {
        setState(() {
          moviefetch(model.id);
        });
      },
      child: Text("Load Actor"),
    );
  }

  moviefetch(int id) async {
    String url =
        "https://yts.mx/api/v2/movie_details.json?movie_id=${id}&with_cast=true";
    Response response = await get(url);
    if (response != null) {
      _responseDecoder(response.body);
    }
  }

  _responseDecoder(String body) {
    List<dynamic> actorlist = json.decode(body)["data"]["movie"]["cast"];
    List<Widget> tempList = List();
    for (var i = 0; i < actorlist.length; i++) {
      Map eachMovie = actorlist[i];
      String name = eachMovie["name"];
      String actorImg = eachMovie["url_small_image"] != null
          ? eachMovie["url_small_image"]
          : "No image";
      print(actorImg);
      Widget actorList = _img(actorImg, name);
      tempList = [...tempList, actorList].toList();
    }
    _actorList = tempList;
    print(_myList());
    setState(() {});
  }

  Widget _myList() {
    return SizedBox(
      height: 300,
      width: width,
      child: ListView(
        children: _actorList,
      ),
    );
  }

  Widget _img(String img, String name) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          img != "No image"
              ? Image.network(
                  img,
                  width: 20.0,
                  height: 20.0,
                )
              : Text("No Image"),
          SizedBox(
            width: 5,
          ),
          Text(name),
        ],
      ),
    ));
  }
}
