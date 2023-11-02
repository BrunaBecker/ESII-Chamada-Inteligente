import 'attendance_entity.dart';
import 'classroom_entity.dart';
import 'person_entity.dart';
import 'register_student_entity.dart';
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
    required super.setting,
    required this.registration,
    required this.classrooms,
    required this.waivers,
    required this.attendances,
  });

  RegisterStudentEntity registration;
  List<ClassroomEntity> classrooms;
  List<WaiverEntity> waivers;
  List<AttendanceEntity> attendances;
}
