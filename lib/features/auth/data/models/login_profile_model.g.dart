// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginProfileModelAdapter extends TypeAdapter<LoginProfileModel> {
  @override
  final int typeId = 1;

  @override
  LoginProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginProfileModel(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      gender: fields[2] as int?,
      role: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginProfileModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
