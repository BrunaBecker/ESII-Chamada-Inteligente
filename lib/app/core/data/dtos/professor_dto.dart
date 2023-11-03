import 'dart:convert';

import '../../domain/entities/professor_entity.dart';
import '../../utils/app_date_utils.dart';
import 'classroom_dto.dart';
import 'location_dto.dart';
import 'register_professor_dto.dart';
import 'setting_dto.dart';

class ProfessorDto extends ProfessorEntity {
  ProfessorDto({
    required super.siape,
    required super.locations,
    required super.classrooms,
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required super.password,
    required super.setting,
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
      setting: entity.setting,
      siape: entity.siape,
      locations: entity.locations,
      classrooms: entity.classrooms,
    );
  }

  factory ProfessorDto.fromMap(Map<String, dynamic> map) {
    // Mapping Locations
    List<LocationDto> locations = [];
    for (var location in map["locations"]) {
      locations.add(LocationDto.fromMap(location));
    }
    // Mapping Classrooms
    List<ClassroomDto> classrooms = [];
    for (var classroom in map["classrooms"]) {
      classrooms.add(ClassroomDto.fromMap(classroom));
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
      setting: SettingDto.fromMap(map["setting"]),
      siape: RegisterProfessorDto.fromMap(map["siape"]),
      locations: locations,
      classrooms: classrooms,
    );
  }

  Map<String, dynamic> toMap() {
    // Mapping Locations
    List<Map<String, dynamic>> locationsAsMap = [];
    for (var location in locations) {
      locationsAsMap.add(LocationDto.fromEntity(location).toMap());
    }
    // Mapping Classrooms
    List<Map<String, dynamic>> classroomsAsMap = [];
    for (var classroom in classrooms) {
      classroomsAsMap.add(ClassroomDto.fromEntity(classroom).toMap());
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
      "setting": SettingDto.fromEntity(setting).toMap(),
      "siape": RegisterProfessorDto.fromEntity(siape).toMap(),
      "locations": locationsAsMap,
      "classrooms": classroomsAsMap,
    };
  }

  factory ProfessorDto.fromJson(String source) => ProfessorDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
