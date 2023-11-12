import 'person_entity.dart';

class CommentEntity {
  CommentEntity({
    required this.id,
    required this.content,
    required this.author,
    this.replyTo,
  });

  int id;
  String content;
  PersonEntity author;
  CommentEntity? replyTo;
}
