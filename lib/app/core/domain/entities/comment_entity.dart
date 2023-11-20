class CommentEntity {
  CommentEntity({
    this.id,
    required this.content,
    required this.personId,
    this.comment,
  });

  int? id;
  String content;
  int personId;
  CommentEntity? comment;
}
