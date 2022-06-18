import 'package:hive/hive.dart';

part 'gender.g.dart';

@HiveType(typeId: 2)
enum Gender {
  @HiveField(0)
  // ignore: constant_identifier_names
  MALE,
  @HiveField(1)
  // ignore: constant_identifier_names
  FEMALE
}
