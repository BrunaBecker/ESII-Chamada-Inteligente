import 'dart:convert';

import '../../domain/entities/professor_entity.dart';
import '../../utils/app_date_utils.dart';
import 'picture_dto.dart';
import 'register_college_id_dto.dart';
import 'setting_dto.dart';

class ProfessorDto extends ProfessorEntity {
  ProfessorDto({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required super.password,
    required super.register,
    super.setting,
    required super.profileImage,
  });

  factory ProfessorDto.fromEntity(ProfessorEntity entity) {
    return ProfessorDto(
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

  factory ProfessorDto.fromMap(Map<String, dynamic> map) {
    SettingDto? setting;
    if (map["setting"] != null) {
      setting = SettingDto.fromMap(map["setting"]);
    }

    return ProfessorDto(
      id: map["id"],
      name: map["name"],
      socialName: map["socialName"],
      birthDate: AppDateUtils.storageDateFormat.parse(map["birthDate"]),
      isActive: map["isActive"],
      cpf: map["cpf"],
      email: map["email"],
      password: map["password"],
      register: RegisterCollegeIdDto.fromMap(map["register"]),
      setting: setting,
      profileImage: PictureDto.fromMap(map["profileImage"]),
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
      "setting":
          setting != null ? SettingDto.fromEntity(setting!).toMap() : null,
      "profileImage": profileImage != null
          ? PictureDto.fromEntity(profileImage!).toMap()
          : null,
    };
  }

  factory ProfessorDto.fromJson(String source) =>
      ProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
