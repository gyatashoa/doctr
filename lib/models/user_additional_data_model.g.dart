// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_additional_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdditionalDataModelAdapter
    extends TypeAdapter<UserAdditionalDataModel> {
  @override
  final int typeId = 1;

  @override
  UserAdditionalDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAdditionalDataModel(
      condition: fields[2] as Condition,
      dob: fields[0] as DateTime,
      docId: fields[4] as String?,
      userType: fields[3] as UserType,
      gender: fields[1] as Gender,
    );
  }

  @override
  void write(BinaryWriter writer, UserAdditionalDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dob)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.condition)
      ..writeByte(3)
      ..write(obj.userType)
      ..writeByte(4)
      ..write(obj.docId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdditionalDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
