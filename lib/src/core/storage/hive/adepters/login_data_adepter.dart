import 'package:hive/hive.dart';
import '../../../stubs/kuick_authflow_stub.dart';

class LoginUserDetailsAdapter extends TypeAdapter<LoginUserDetails> {
  @override
  final int typeId = 2;

  @override
  LoginUserDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return LoginUserDetails(
      userId: fields[0] as int?,
      userEmail: fields[1] as String?,
      userName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginUserDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userEmail)
      ..writeByte(2)
      ..write(obj.userName);
  }
}

class LoginDataAdapter extends TypeAdapter<LoginData> {
  @override
  final int typeId = 1;

  @override
  LoginData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return LoginData(
      token: fields[0] as String?,
      newToken: fields[1] as String?,
      userDetails: fields[2] as LoginUserDetails?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.newToken)
      ..writeByte(2)
      ..write(obj.userDetails);
  }
}

class LoginModelAdapter extends TypeAdapter<LoginModel> {
  @override
  final int typeId = 0;

  @override
  LoginModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return LoginModel(
      status: fields[0] as String?,
      redirect: fields[1] as String?,
      redirectId: fields[2] as int?,
      msg: fields[3] as String?,
      data: fields[4] as LoginData?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.redirect)
      ..writeByte(2)
      ..write(obj.redirectId)
      ..writeByte(3)
      ..write(obj.msg)
      ..writeByte(4)
      ..write(obj.data);
  }
}
