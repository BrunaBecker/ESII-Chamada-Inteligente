enum StudentAtAttendanceState {
  present,
  absent,
  justified;

  static StudentAtAttendanceState? fromInt(int value) {
    switch (value) {
      case 0:
        return StudentAtAttendanceState.present;
      case 1:
        return StudentAtAttendanceState.absent;
      case 2:
        return StudentAtAttendanceState.justified;
      default:
        return null;
    }
  }

  int toInt() {
    switch (this) {
      case StudentAtAttendanceState.present:
        return 0;
      case StudentAtAttendanceState.absent:
        return 1;
      case StudentAtAttendanceState.justified:
        return 2;
    }
  }
}
