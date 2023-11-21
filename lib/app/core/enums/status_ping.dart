enum StatusPing {
  successful,
  invalidAttendance,
  unsuccessful,
  validAttendance;

  String toText() {
    switch (this) {
      case StatusPing.successful:
        return 'successful';
      case StatusPing.invalidAttendance:
        return 'invalidAttendance';
      case StatusPing.unsuccessful:
        return 'unsuccessful';
      case StatusPing.validAttendance:
        return 'validAttendance';
    }
  }

  static StatusPing fromText(String text) {
    switch (text) {
      case 'successful':
        return StatusPing.successful;
      case 'invalidAttendance':
        return StatusPing.invalidAttendance;
      case 'unsuccessful':
        return StatusPing.unsuccessful;
      case 'validAttendance':
        return StatusPing.validAttendance;
      default:
        return StatusPing.invalidAttendance;
    }
  }
}
