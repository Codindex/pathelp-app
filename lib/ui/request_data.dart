import 'package:flutter/material.dart';

import '../model/abstract_data.dart';
import '../network/response.dart';
import 'data_list.dart';

class RequestDataList<T extends Data> extends StatefulWidget {
  const RequestDataList({super.key});

  @override
  State<RequestDataList> createState() => _RequestDataListState<T>();
}

class _RequestDataListState<T extends Data> extends State<RequestDataList> {
  late Future<ResponseList<T>> futureDataList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureDataList = fetchDataList<T>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseList<T>>(
      future: futureDataList,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          List<T> dataList = snapshot.data?.dataList ?? [];
          return DataList(dataList);
        }
        if(snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}