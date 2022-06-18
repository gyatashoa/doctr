// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConditionAdapter extends TypeAdapter<Condition> {
  @override
  final int typeId = 3;

  @override
  Condition read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Condition.FIT;
      case 1:
        return Condition.DIABETIC;
      default:
        return Condition.FIT;
    }
  }

  @override
  void write(BinaryWriter writer, Condition obj) {
    switch (obj) {
      case Condition.FIT:
        writer.writeByte(0);
        break;
      case Condition.DIABETIC:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConditionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
