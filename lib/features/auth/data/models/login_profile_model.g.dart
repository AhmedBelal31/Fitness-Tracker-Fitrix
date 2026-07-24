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
      dateOfBirth: fields[4] as DateTime?,
      heightCm: fields[5] as double?,
      lastWeightKg: fields[6] as double?,
      lastMuscleMassKg: fields[7] as double?,
      lastBodyFatPercent: fields[8] as double?,
      phoneNumber: fields[9] as String?,
      weightGoal: fields[10] as double?,
      bodyFatGoal: fields[11] as double?,
      muscleMassGoal: fields[12] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginProfileModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.dateOfBirth)
      ..writeByte(5)
      ..write(obj.heightCm)
      ..writeByte(6)
      ..write(obj.lastWeightKg)
      ..writeByte(7)
      ..write(obj.lastMuscleMassKg)
      ..writeByte(8)
      ..write(obj.lastBodyFatPercent)
      ..writeByte(9)
      ..write(obj.phoneNumber)
      ..writeByte(10)
      ..write(obj.weightGoal)
      ..writeByte(11)
      ..write(obj.bodyFatGoal)
      ..writeByte(12)
      ..write(obj.muscleMassGoal);
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
