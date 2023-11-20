import 'dart:convert';

import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/professor_entity.dart';
import '../../domain/entities/student_entity.dart';
import 'professor_dto.dart';
import 'student_dto.dart';

class CommentDto extends CommentEntity {
  CommentDto({
    super.id,
    required super.content,
    required super.personId,
    super.comment,
  });

  factory CommentDto.fromEntity(CommentEntity entity) {
    return CommentDto(
      id: entity.id,
      content: entity.content,
      personId: entity.personId,
      comment: entity.comment,
    );
  }

  factory CommentDto.fromMap(Map<String, dynamic> map) {
    // Mapping Comment

    return CommentDto(
      id: map["id"],
      content: map["content"],
      personId: map["personId"],
      comment:
          map["comment"] != null ? CommentDto.fromMap(map["comment"]) : null,
    );
  }

  Map<String, dynamic> toMap() {
    final dynamic personAsMap;
    // Checking person type
    if (personId is ProfessorDto) {
      personAsMap = ProfessorDto.fromEntity(personId as ProfessorEntity);
    } else {
      personAsMap = StudentDto.fromEntity(personId as StudentEntity);
    }

    return {
      "id": id,
      "content": content,
      "personId": personAsMap,
      "comment":
          comment != null ? CommentDto.fromEntity(comment!).toMap() : null,
    };
  }

  factory CommentDto.fromJson(String source) =>
      CommentDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
