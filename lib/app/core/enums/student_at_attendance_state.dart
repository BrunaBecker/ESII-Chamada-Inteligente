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

  String toText() {
    switch (this) {
      case StudentAtAttendanceState.present:
        return 'present';
      case StudentAtAttendanceState.absent:
        return 'absent';
      case StudentAtAttendanceState.justified:
        return 'justified';
    }
  }

  static StudentAtAttendanceState fromText(String text) {
    switch (text) {
      case 'present':
        return StudentAtAttendanceState.present;
      case 'absent':
        return StudentAtAttendanceState.absent;
      case 'justified':
        return StudentAtAttendanceState.justified;
      default:
        return StudentAtAttendanceState.absent;
    }
  }
}
