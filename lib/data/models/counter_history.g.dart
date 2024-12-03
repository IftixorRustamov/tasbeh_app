// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterHistoryAdapter extends TypeAdapter<CounterHistory> {
  @override
  final int typeId = 1;

  @override
  CounterHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounterHistory(
      counter: fields[1] as int,
      countedDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CounterHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.counter)
      ..writeByte(2)
      ..write(obj.countedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
