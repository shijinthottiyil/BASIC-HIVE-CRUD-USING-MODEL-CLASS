import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class Model {
  @HiveField(0)
  final String name;

  Model({required this.name});
}
