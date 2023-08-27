import '../model/abstract_data.dart';

typedef DataMap<T extends Data> = Map<int, T>;
// class DataMap<T extends Data> {
//   final Map<int, T> dataMap = {};
//
//   DataMap();
//
//   T addEntry(T data) {
//     dataMap[data.id] = data;
//   }
// }