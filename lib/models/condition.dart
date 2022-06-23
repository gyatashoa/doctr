import 'package:hive/hive.dart';

part 'condition.g.dart';

@HiveType(typeId: 3)
enum Condition {
  @HiveField(0)
  // ignore: constant_identifier_names
  FIT,
  @HiveField(1)
  // ignore: constant_identifier_names
  DIABETIC,
}
