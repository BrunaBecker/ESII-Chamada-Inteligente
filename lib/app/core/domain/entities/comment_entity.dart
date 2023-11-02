import 'person_entity.dart';
import 'waiver_entity.dart';

class CommentEntity {
  CommentEntity({
    required this.id,
    required this.content,
    required this.author,
    required this.waiver,
    this.replyTo,
  });

  int id;
  String content;
  PersonEntity author;
  WaiverEntity waiver;
  CommentEntity? replyTo;
}
