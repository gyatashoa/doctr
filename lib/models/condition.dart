import 'package:hive/hive.dart';

part 'condition.g.dart';

@HiveType(typeId: 3)
enum Condition {
  @HiveField(0)
  FIT,
  @HiveField(1)
  DIABETIC,
}
