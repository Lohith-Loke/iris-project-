// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/function/apidata.dart';
import 'package:myapp/function/movie2.dart';
import 'package:myapp/function/movies.dart';

class MovieScreen extends StatefulWidget {
  final Movies movies;
  const MovieScreen({Key? key, required this.movies}) : super(key: key);
  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String errorMessage = 'loading.....';
  List list = [];
  getdata() async {
    Apidata l = await loaddata(widget.movies.id);
    if (l.error == null) {
      print(l.data);
      setState(() {
        list = l.data;
      });
    } else {
      switch (l.error) {
        case "nointernet":
          setState(() {
            errorMessage = "No Internet";
          });
          break;
        default:
          setState(() {
            errorMessage = l.error.toString();
          });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.movies);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movies.fullTitle ?? 'no title error'),
      ),
      body: loadscreen(height, width, list),
    );
  }

  Widget loadscreen(double height, double width,List list) {
    if (list.isEmpty) {
      return (Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            if (errorMessage == "No Internet")
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    getdata();
                  });
                },
                child: const Text('Reload '),
              ),
          ],
        ),
      ));
    }
    Movieview movieview = list[0];
    return ListView(
      children: [
        //  baground image
        SizedBox(
          height: height / 4,
          width: width,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movieview.posters2!.posters![0].link ??
                      "https://imdb-api.com/posters/original/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg"),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                  colors: [Colors.black12, Colors.white10],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.4, 0.7],
                  tileMode: TileMode.repeated,
                )),
          ),
        ),
        // image stack up
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // baground image

                Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.blueAccent)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width/1.8,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                movieview.fullTitle ?? "Inception (2010)",
                                
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            // imdb rating
                            Row(
                              children: [
                                Text(
                                  "IMDB RATINGS:  ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    movieview.imDbRating ?? "8.8",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Ink.image(
                                    image: NetworkImage(
                                        "https://m.media-amazon.com/images/G/01/imdb/images-ANDW73HA/favicon_desktop_32x32._CB1582158068_.png"),
                                    fit: BoxFit.scaleDown,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Text(
                                    "RottenTomatoes: ${movieview.ratings?.rottenTomatoes}"),
                                SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Ink.image(
                                        image: NetworkImage(
                                            "https://www.rottentomatoes.com/assets/pizza-pie/images/favicon.ico")))
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'ContentRating: ${movieview.contentRating}',
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Runtime: ${movieview.runtimeMins} mins',
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      // poster
                      SizedBox(
                        height: height / 4,
                        width: width / 3,
                        child: Ink.image(
                            image: NetworkImage(movieview
                                    .posters2!.posters![0].link ??
                                "https://imdb-api.com/posters/original/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg"),
                            fit: BoxFit.cover),
                      ),
                      // poster
                    ],
                  ),
                ),
                // imdb rating

                SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "The Storyline",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),

                SizedBox(
                  width: width,
                  child: Text(
                    movieview.plot ??
                        "      A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom the project and his team to disaster.",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 101, 101, 101)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: width,
                    child: Row(
                      children: [
                        Text(
                          "Available Languages:",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          movieview.languages ?? "English, Japanese, French",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 101, 101, 101)),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Director:",
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        movieview.directors ?? ' Christopher Nolan',
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 101, 101, 101)),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text(
                      "CAST:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                      child: Text(
                        movieview.stars ??
                            "Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 101, 101, 101)),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ]),
                ),

                Row(
                  children: [
                    Text(
                      "Awards:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                      child: Text(
                        movieview.awards ??
                            ' Top rated movie #13 | Won 4 Oscars, 157 wins & 220 nominations total',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 101, 101, 101)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
// imdb rating
      ],
    );
  }

  void navigate(BuildContext context) {
    Navigator.pop(context);
  }
}
