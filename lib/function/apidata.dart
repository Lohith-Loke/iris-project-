// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:myapp/function/movies.dart';

// ignore: camel_case_types
class apidata {
  String? error;
  List data;
  apidata({required this.data, this.error});
  @override
  String toString() {
    if (error == null) {
      return '  error:null\n,  data:present';
    }
    return 'error:$error';
  }
}

Future<void> main(List<String> args) async {
  // print("start");
  // apidata api = apidata(data: [], error: "init");
  apidata api = await loaddata(1);
  print(api);
  // print("end");
}

loaddata(cat) async {
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
  String str = 'https://imdb-api.com/en/API/$catogory/k_u0cvz5wi';
  // String str = 'https://imdb-api.com/en/API/$catogory/k_u0cvz5ww';
  
  List l = await fetchdata(str);

  return apidata(data: l[0], error: l[1]);
}

Future<List<Object?>> fetchdata(str) async {
  var url = Uri.parse(str);
  List list = [];
  try {
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      String data = response.body;
      var errors = convert.jsonDecode(data)['errorMessage'];
      if (errors == "") {
        // print('no errors');
        var jsondata = convert.jsonDecode(data)['items'];
        for (var i = 0; i < jsondata.length; i++) {
          list.add(Movies.fromJson(jsondata[i]));
        }
        // print(list[0].toString());
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
      // print("nointernet");
    }
    return [list, "nointernet"];
  }
}
