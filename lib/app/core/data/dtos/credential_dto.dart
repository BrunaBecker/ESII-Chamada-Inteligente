import 'dart:convert';

import '../../domain/entities/credential_entity.dart';

class CredentialDto extends CredentialEntity {
  CredentialDto({
    required super.identifier,
    required super.password,
  });

  factory CredentialDto.fromEntity(CredentialEntity entity) {
    return CredentialDto(
      identifier: entity.identifier,
      password: entity.password,
    );
  }

  factory CredentialDto.fromMap(Map<String, dynamic> map) {
    return CredentialDto(
      identifier: map["identifier"],
      password: map["password"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "identifier": identifier,
      "password": password,
    };
  }

  factory CredentialDto.fromJson(String source) =>
      CredentialDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
