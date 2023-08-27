import "package:flutter/material.dart";

import '../model/index.dart';

import 'detail.dart';

class DataList<T extends Data> extends StatelessWidget {
  final List<T> dataList;

  const DataList(this.dataList, {super.key});

  @override
  Widget build(BuildContext context) {
    final Map<int, T> data = switch (T) {
      InterestPoint => InterestPoint.points,
      Category => Category.categories,
      _ => throw Exception("Not known datatype")
    }.cast<int, T>();

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: InterestPoint.points.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Text(data[i]!.id.toString()),
          title: Text(data[i]!.name),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => Detail(data[i]!)
            )
          ),
        );
      },
      separatorBuilder: (context, i) => const Divider(),
    );
  }
}