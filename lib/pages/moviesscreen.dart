import 'package:flutter/material.dart';
import 'package:myapp/function/movies.dart';

class MovieScreen extends StatelessWidget {
 final Movies movies;

  // final Movies movies;
  
  // var movies2;

  const MovieScreen({Key? key, required this.movies}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies '),
      ),
      body: Center(
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              navigate(context);
               print(movies);
            },
            child: const Text('Go back!'),
          ),

        ]),
      ),
    );
  }
  
  void navigate(BuildContext context) {
     Navigator.pop(context);
  }
}
