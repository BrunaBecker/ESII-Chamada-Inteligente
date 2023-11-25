import 'dart:convert';

import '../../domain/entities/professor_entity.dart';
import '../../utils/app_date_utils.dart';
import 'picture_dto.dart';
import 'register_college_id_dto.dart';
import 'setting_dto.dart';

class ProfessorDto extends ProfessorEntity {
  ProfessorDto({
    super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    super.isActive = true,
    required super.cpf,
    required super.email,
    required super.password,
    super.setting,
    super.profileImage,
    required super.register,
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
    // Mapping Setting
    SettingDto? setting;
    if (map["setting"] != null) {
      setting = SettingDto.fromMap(map["setting"]);
    }

    // Mapping Profile Image
    PictureDto? profileImage;
    if (map["profileImage"] != null) {
      profileImage = PictureDto.fromMap(map["profileImage"]);
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
      profileImage: profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Setting
    Map<String, dynamic>? settingAsMap;
    if (setting != null) {
      settingAsMap = SettingDto.fromEntity(setting!).toMap();
    }

    // Mapping Profile Image
    Map<String, dynamic>? profileImageAsMap;
    if (profileImage != null) {
      profileImageAsMap = PictureDto.fromEntity(profileImage!).toMap();
    }

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
      "setting": settingAsMap,
      "profileImage": profileImageAsMap,
    };
  }

  factory ProfessorDto.fromJson(String source) =>
      ProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
