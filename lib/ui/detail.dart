import "package:flutter/material.dart";

import '../model/index.dart';

class Detail<T extends Data> extends StatelessWidget {
  final T data;

  const Detail(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Center(
        child: Column(
          children: data.widgetFields,
        ),
      ),
    );
  }
}