import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/index.dart';

const url = "http://pat.infolab.ecam.be:60818";

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

  factory ResponseList.fromJson(List<dynamic> json) =>
    ResponseList(
      json.map((entry) => Data.fromJson(entry) as T).toList()
    );
}

Future<ResponseList<T>> fetchDataList<T extends Data>() async {
  final response = switch (T) {
    InterestPoint => await http.get(Uri.parse("$url/points")),
    Category => await http.get(Uri.parse("$url/categories")),
    _ => throw Exception("Not a defined Data subtype")
  };

  return switch(response.statusCode) {
    200 => ResponseList<T>.fromJson(jsonDecode(response.body) as List<dynamic>),
    _ => throw Exception("Status != 200")
  };
}

class ResponseLogin {
  static String? token;

  static String fromJson(Map<String, dynamic> json) {
    token = json["token"];
    return "Token saved";
  }
}

Future<String?> fetchLogin(String name, String password) async {
  final response = await http.post(
    Uri.parse("$url/login"),
    body: {
      "username": name,
      "password": password
    }
  );

  return switch(response.statusCode) {
    200 => ResponseLogin.fromJson(jsonDecode(response.body)),
    401 => "No user saved with this name",
    403 => "Wrong password",
    _ => throw Exception("Status != 200")
  };
}