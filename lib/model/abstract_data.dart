import 'package:flutter/material.dart';

import '../ui/detail.dart';
import 'category.dart';
import 'point.dart';

abstract class Data {
  final int id;
  String get name;

  Data(this.id);

  factory Data.fromJson(Map<String, dynamic> json) => switch (json) {
    != null when json["point_id"] != null => InterestPoint.fromJson(json),
    != null when json["category_id"] != null => Category.fromJson(json),
    _ => throw Exception("Unknown data")
  };

  Map<String, dynamic> toJson();

  List<Widget> get widgetFields;

  void onClick(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return Detail(this);
            }
        )
    );
  }
}