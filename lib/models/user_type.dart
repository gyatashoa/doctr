import 'package:hive/hive.dart';

part 'user_type.g.dart';

@HiveType(typeId: 4)
enum UserType {
  @HiveField(0)
  user,
  @HiveField(1)
  doctor
}
