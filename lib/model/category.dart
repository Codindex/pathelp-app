import 'package:flutter/material.dart';

import '../ui/detail.dart';
import 'abstract_data.dart';
import 'data_map.dart';
import 'point.dart';

class Category extends Data {
  static DataMap<Category> categories = {};

  @override
  String name;
  String description;
  List<InterestPoint>? points;

  Category(super.id, this.name, this.description, this.points) {
    if (points != null) {
      for (InterestPoint point in points!) {
        point.categories.add(this);
      }
    }

    categories[id] = this;
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      json['category_id'],
      json['name'],
      json["description"],
      [
        for (Map<String, dynamic> point in json["points"] ?? [])
          InterestPoint.fromJson(point)
      ]
  );

  @override
  Map<String, dynamic> toJson() => {
    "point_id": id,
    "name": name,
    "description": description,
    "points": [
      for (InterestPoint point in points ?? [])
        point.toJson()
    ]
  };

  @override
  List<Widget> get widgetFields => [
    Text(
        name
    ),
    Text(
        description
    ),
    Card(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              title: Text("Points"),
            ),
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return ListTile(
                        title: Text(points![index].id.toString()),
                        subtitle: Text(points![index].name),
                        onTap: () => points![index].clickPoint(context),
                      );
                    }
                ),
                itemExtent: 50.0
            )
          ],
        )
    )
  ];

  void clickCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Detail(this);
        }
      )
    );
  }
}