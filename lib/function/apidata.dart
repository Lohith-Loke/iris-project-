// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/function/movie2.dart';
import 'dart:convert' as convert;
import 'package:myapp/function/movies.dart';



class Apidata {
  String? error;
  List data;
  Apidata({required this.data, this.error});
  @override
  String toString() {
    if (error == null) {
      return '  error:null/n,  data:present';
    }
    return 'error:$error';
  }
}

Future<void> main(List<String> args) async {
  // Apidata api = (await fetchdetails("tt1375666")) as Apidata;
  // print(api);
}




Future<List<Object?>> fetchdetails(String id) async {
  var url = Uri.parse("https://imdb-api.com/en/API/Title/k_qvz7b35k/$id/Posters,Ratings,");
  List list = [];
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var errors = convert.jsonDecode(data)['errorMessage'];
      if (errors == null) {
        print("no data error ");
        // parse json data
        Movieview movieview= Movieview.fromJson(convert.jsonDecode(data));
        list.add(movieview);
        return [list, null];
      } else {
        // print(data);
        return [list, errors.toString()];
      }
    } else {
      return [list, "improper-res"];
    }
  } catch (e) {
    if (e is SocketException || e is TimeoutException) {
      print("nointernet");
    }
    return [list, "nointernet"];
  }
}

loaddata(cat) async {
  if (cat.runtimeType != 2.runtimeType) {
    List l = await fetchdetails(cat);
    return Apidata(data: l[0], error: l[1]);
  }

  String catogory = "Top250Movies";
  switch (cat) {
    case 1:
      catogory = "Top250Movies";
      break;
    case 2:
      catogory = "Top250TVs";
      break;
    case 3:
      catogory = "MostPopularMovies";
      break;
    case 4:
      catogory = "MostPopularTVs";
      break;
    default:
  }
  List l = await fetchdata(catogory);
  return Apidata(data: l[0], error: l[1]);
}

Future<List<Object?>> fetchdata(str) async {
  var url = Uri.parse('https://imdb-api.com/en/API/$str/k_qvz7b35k');
  List list = [];
  try {
    http.Response response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      String data = response.body;
      var errors = convert.jsonDecode(data)['errorMessage'];
      if (errors == "") {
        // print(data);
        var jsondata = convert.jsonDecode(data)['items'];
        for (var i = 0; i < jsondata.length; i++) {
          list.add(Movies.fromJson(jsondata[i]));
        }
        print(list[0].toString());
        return [list, null];
      } else {
        // print(errors);
        return [list, "apierror"];
      }
    }
    // improper responce
    return [list, "improperres"];
  } catch (e) {
    if (e is SocketException || e is TimeoutException) {
      print("nointernet");
    }
    print(e.toString());

    return [list, e.toString()];
  }
}
