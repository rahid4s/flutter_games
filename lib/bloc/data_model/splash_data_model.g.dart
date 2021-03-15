// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SplashDataModelAdapter extends TypeAdapter<SplashDataModel> {
  @override
  final int typeId = 0;

  @override
  SplashDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SplashDataModel(
      isNew: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SplashDataModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isNew);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
