import 'dart:convert';

import '../../domain/entities/student_entity.dart';
import '../../utils/app_date_utils.dart';
import 'register_college_id_dto.dart';

class StudentDto extends StudentEntity {
  StudentDto({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required super.password,
    required super.register,
    required super.setting,
    required super.profileImage,
  });

  factory StudentDto.fromEntity(StudentEntity entity) {
    return StudentDto(
      id: entity.id,
      name: entity.name,
      socialName: entity.socialName,
      birthDate: entity.birthDate,
      isActive: entity.isActive,
      cpf: entity.cpf,
      email: entity.email,
      password: entity.password,
      register: entity.register,
      setting: entity.setting,
      profileImage: entity.profileImage,
    );
  }

  factory StudentDto.fromMap(Map<String, dynamic> map) {
    return StudentDto(
      id: map["id"],
      name: map["name"],
      socialName: map["socialName"],
      birthDate: AppDateUtils.storageDateFormat.parse(map["birthDate"]),
      isActive: map["isActive"],
      cpf: map["cpf"],
      email: map["email"],
      password: map["password"],
      register: RegisterCollegeIdDto.fromMap(map["register"]),
      setting: map["setting"],
      profileImage: map["profileImage"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "socialName": socialName,
      "birthDate": AppDateUtils.storageDateFormat.format(birthDate),
      "isActive": isActive,
      "cpf": cpf,
      "email": email,
      "password": password,
      "register": RegisterCollegeIdDto.fromEntity(register).toMap(),
      "setting": setting,
      "profileImage": profileImage,
    };
  }

  factory StudentDto.fromJson(String source) =>
      StudentDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
