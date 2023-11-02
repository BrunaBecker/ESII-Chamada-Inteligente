import 'comment_entity.dart';
import 'file_mac_fi_entity.dart';
import 'student_entity.dart';

class WaiverEntity {
  WaiverEntity({
    required this.id,
    required this.file,
    required this.sendDate,
    required this.acceptionDate,
    required this.isAccepted,
    required this.comment,
    required this.student,
  });

  int id;
  FileMacFiEntity file;
  DateTime sendDate;
  DateTime acceptionDate;
  bool isAccepted;
  CommentEntity comment;
  StudentEntity student;
}
