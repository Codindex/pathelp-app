import "package:flutter/material.dart";

import '../model/index.dart';

import 'detail.dart';

class DataList<T extends Data> extends StatelessWidget {
  final List<T> dataList;

  const DataList(this.dataList, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("okay");
    final Map<int, T> data = switch (T) {
      InterestPoint => InterestPoint.points,
      Category => Category.categories,
      _ => throw Exception("Not known datatype")
    }.cast<int, T>();
    var keys = data.keys.toList();

    return Scaffold(
      appBar: AppBar(
          title: const Text("Data list")
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: InterestPoint.points.length,
        itemBuilder: (context, i) {
          // debugPrint(i.toString());
          // debugPrint(InterestPoint.points.toString());
          var key = keys[i];
          return ListTile(
            leading: Text(data[key]!.id.toString()),
            title: Text(data[key]!.name),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => Detail(data[key]!)
              )
            ),
          );
        },
        separatorBuilder: (context, i) => const Divider(),
      )
    );
  }
}