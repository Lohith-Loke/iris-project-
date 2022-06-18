// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/function/movies.dart';
import 'package:myapp/pages/moviesscreen.dart';
import 'package:myapp/pages/secondpage.dart';
import 'package:myapp/function/apidata.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  List list = [];
  String dropdownValue = 'Top 250 Movies';
  int cat = 1;
  List<String> options = [
    'Top 250 Movies',
    'Top 250 TVs',
    'Most Popular Movies',
    'Most Popular TVs'
  ];

  String errorMessage = 'Loading .....';
  void getdata() async {
    apidata l = await loaddata(cat);
    if (l.error == null) {
      setState(() {
        list = l.data;
      });
    } else {
      // print(l.error);
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Imdb Top movies list '),
        ),
        body: SizedBox(
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
                width: width,
                child: topbar(context),
              ),
              SizedBox(
                height: height * 0.8,
                width: width,
                child: loadscreen(list),
              )
            ],
          ),
        ));
  }

  void navigate(context, Movies movies) {
   
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieScreen(movies: movies,)),
    );
  }

  Widget loadscreen(List list) {
    if (list.isNotEmpty) {
      return (ListView.builder(
          itemCount: list.length,
          addAutomaticKeepAlives: false,
          itemBuilder: (BuildContext context, int index) {
            return movieCard(context, list[index]);
          }));
    } else {
      return (Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            if(errorMessage=="No Internet")
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
  }

  Widget textcontainer(text, {double fontsize = 18}) => Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        // decoration: BoxDecoration(
        //     border: Border.all(color: Colors.blueAccent)),
        child: Text(
          text,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
            fontSize: fontsize,
          ),
        ),
      );

  Container movieCard(BuildContext context, Movies movies) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(5.0),
      child: Card(
          shadowColor: const Color.fromARGB(255, 216, 6, 6),
          elevation: 12,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () => {navigate(context, movies)},
            child: SizedBox(
              width: width * (.6),
              child: Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                    // color: Colors.green[400],
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * (0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(1, 1, 1, 10),
                              padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.blueAccent)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  movies.title,
                                  textAlign: TextAlign.start,
                                  // overflow: TextOverflow.ellipsis,
                                  // softWrap: false,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          textcontainer("Year:${movies.year}"),
                          Row(children: [
                            textcontainer("Imdb Rating:${movies.imDbRating}"),
                            textcontainer("(${movies.imDbRatingCount})",
                                fontsize: 10)
                          ]),
                          textcontainer("Crew", fontsize: 19),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.all(1.0),
                              padding: const EdgeInsets.all(1.0),
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.blueAccent)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  movies.crew,
                                  textAlign: TextAlign.start,
                                  // overflow: TextOverflow.ellipsis,
                                  // softWrap: false,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(1.0),
                      padding: const EdgeInsets.all(3.0),
                      // decoration:
                      //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                      child: Ink.image(
                        image: NetworkImage(movies.image
                            // "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX128_CR0,3,128,176_AL_.jpg",
                            ),
                        height: 250,
                        width: width * (0.35),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  topbar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        SizedBox(
          width: width,
          height: height * 0.1,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              int i = options.indexOf(newValue!);
              setState(() {
                list = [];
              });
              setState(() {
                cat = i + 1;
                dropdownValue = newValue;
                getdata();
              });
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
