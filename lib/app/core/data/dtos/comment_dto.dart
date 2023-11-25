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
    CommentDto? comment;
    if (map["comment"] != null) {
      comment = CommentDto.fromMap(map["comment"]);
    }

    return CommentDto(
      id: map["id"],
      content: map["content"],
      personId: map["personId"],
      comment: comment,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> personAsMap;
    // Checking person type
    if (personId is ProfessorDto) {
      personAsMap =
          ProfessorDto.fromEntity(personId as ProfessorEntity).toMap();
    } else {
      personAsMap = StudentDto.fromEntity(personId as StudentEntity).toMap();
    }
    // Mapping Comment
    Map<String, dynamic>? commentAsMap;
    if (comment != null) {
      commentAsMap = CommentDto.fromEntity(comment!).toMap();
    }

    return {
      "id": id,
      "content": content,
      "personId": personAsMap,
      "comment": commentAsMap,
    };
  }

  factory CommentDto.fromJson(String source) =>
      CommentDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
