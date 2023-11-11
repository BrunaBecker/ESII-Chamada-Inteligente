import 'dart:convert';

import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/professor_entity.dart';
import '../../domain/entities/student_entity.dart';
import 'professor_dto.dart';
import 'student_dto.dart';
import 'waiver_dto.dart';

class CommentDto extends CommentEntity {
  CommentDto({
    required super.id,
    required super.content,
    required super.author,
    super.replyTo,
  });

  factory CommentDto.fromEntity(CommentEntity entity) {
    return CommentDto(
      id: entity.id,
      content: entity.content,
      author: entity.author,
      replyTo: entity.replyTo,
    );
  }

  factory CommentDto.fromMap(Map<String, dynamic> map) {
    final dynamic person;
    // Checking person type
    if ((map["person"] as Map).containsKey("siape")) {
      person = ProfessorDto.fromMap(map["person"]);
    } else {
      person = StudentDto.fromMap(map["person"]);
    }

    return CommentDto(
      id: map["id"],
      content: map["content"],
      author: person,
      replyTo: CommentDto.fromMap(map["replyTo"]),
    );
  }

  Map<String, dynamic> toMap() {
    final dynamic personAsMap;
    // Checking person type
    if (author is ProfessorDto) {
      personAsMap = ProfessorDto.fromEntity(author as ProfessorEntity);
    } else {
      personAsMap = StudentDto.fromEntity(author as StudentEntity);
    }

    return {
      "id": id,
      "content": content,
      "author": personAsMap,
      "replyTo": replyTo != null
          ? CommentDto.fromEntity(replyTo as CommentEntity).toMap()
          : null,
    };
  }

  factory CommentDto.fromJson(String source) =>
      CommentDto.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
