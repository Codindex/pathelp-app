import 'package:flutter/material.dart';

import '../ui/detail.dart';
import 'abstract_data.dart';
import 'data_map.dart';
import 'category.dart';

class InterestPoint extends Data {
  // static List<InterestPoint> points = [];
  static final DataMap<InterestPoint> points = {};

  // final int id;
  @override
  String name;
  String description;
  List<Category> categories;
  List<InterestPoint> miniPoints;

  InterestPoint(
      super.id,
      this.name,
      this.description,
      this.categories,
      this.miniPoints) {
    points[id] = this;
  }

  factory InterestPoint.fromJson(Map<String, dynamic> json) => InterestPoint(
    json["point_id"],
    json['name'],
    json['description'],
    [
      for (Map<String, dynamic> category in [...?json["categories"]])
        Category.fromJson(category)
    ],
    [
      for (Map<String, dynamic> point in [...?json["points"]])
        InterestPoint.fromJson(point)
    ]
  );

  @override
  Map<String, dynamic> toJson() => {
    "point_id": id,
    "name": name,
    "description": description,
    if (categories.isNotEmpty)
      "categories": categories,
    if (miniPoints.isNotEmpty)
      "points": [
        for (InterestPoint point in miniPoints)
          point.toJson()
      ]
  };

  @override
  List<Widget> get widgetFields {
    return [
      Text(
          name
      ),
      Text(
          description
      ),
      if (categories.isNotEmpty) Card(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              title: Text("Categories"),
            ),
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListTile(
                        title: Text(categories[index].id.toString()),
                        subtitle: Text(categories[index].name),
                        onTap: () => categories[index].clickCategory(context),
                      );
                    },
                  childCount: categories.length
                ),
                itemExtent: 50.0
            )
          ],
        )
      ),
      if (miniPoints.isNotEmpty) Card(
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
                    title: Text(miniPoints[index].id.toString()),
                    subtitle: Text(miniPoints[index].name),
                    onTap: () => miniPoints[index].clickPoint(context),
                  );
                }
              ),
              itemExtent: 50.0
            )
          ],
        )
      )
    ];
  }
  // ListView.builder(
  // itemCount: categories.length,
  // itemBuilder: (context, i) {
  // return ListTile(
  // title: Text(categories[i].name),
  // subtitle: Text(categories[i].description),
  // onTap: () => _clickCategory(context, i),
  // );
  // },
  // )

  void clickPoint(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return Detail(this);
            }
        )
    );
  }
}