import 'attendance_entity.dart';
import 'classroom_entity.dart';
import 'person_entity.dart';
import 'waiver_entity.dart';

class StudentEntity extends PersonEntity {
  StudentEntity({
    required super.id,
    required super.name,
    required super.socialName,
    required super.birthDate,
    required super.isActive,
    required super.cpf,
    required super.email,
    required super.password,
    required super.register,
    required super.setting,
    required super.profileImage,
    required super.comments,
    required super.notifications,
    required this.classrooms,
    required this.waivers,
    required this.attendances,
  });

  List<ClassroomEntity> classrooms;
  List<WaiverEntity> waivers;
  List<AttendanceEntity> attendances;
}
