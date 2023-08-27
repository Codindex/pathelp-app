import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/index.dart';

class Response<T> {
  final T data;

  Response(this.data);

  factory Response.fromJson(dynamic json) =>
    Response(Data.fromJson(json) as T);
    // List<dynamic> list = json['teachers'];
    // List<Data> data =
    //   list.map((item) => Data.fromJson(item)).toList();
    // return Response(data);
}

class ResponseList<T extends Data> {
  final List<T> dataList;

  ResponseList(this.dataList);

  factory ResponseList.fromJson(dynamic json) =>
    ResponseList(
      (json as List).map((entry) => Data.fromJson(entry)).toList() as List<T>
    );
}

Future<ResponseList<T>> fetchDataList<T extends Data>() async {
  const url = "http://pat.infolab.ecam.be:60818";
  final response = switch (T) {
    InterestPoint => await http.get(Uri.parse("$url/points")),
    Category => await http.get(Uri.parse("$url/categories")),
    _ => throw Exception("Not a defined Data subtype")
  };
  if (response.statusCode == 200) {
    return ResponseList<T>.fromJson(jsonDecode(response.body));
  }
  throw Exception("Status != 200");
}