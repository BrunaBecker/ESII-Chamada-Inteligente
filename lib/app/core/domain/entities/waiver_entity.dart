import 'comment_entity.dart';
import 'file_mac_fi_entity.dart';
import 'student_entity.dart';

class WaiverEntity {
  WaiverEntity({
    this.id,
    required this.file,
    required this.description,
    required this.sendDate,
    this.acceptionDate,
    this.isAccepted = false,
    this.comment,
    required this.student,
    required this.attendanceStatusId,
  });

  int? id;
  FileMacFiEntity file;
  String description;
  DateTime sendDate;
  DateTime? acceptionDate;
  bool isAccepted;
  CommentEntity? comment;
  StudentEntity student;
  int attendanceStatusId;
}
