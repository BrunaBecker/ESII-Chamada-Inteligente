enum StatusNotification {
  urgent,
  normal,
  low;

  static fromText(String text) {
    switch (text) {
      case 'urgent':
        return StatusNotification.urgent;
      case 'normal':
        return StatusNotification.normal;
      case 'low':
        return StatusNotification.low;
      default:
        return StatusNotification.normal;
    }
  }

  String toText() {
    switch (this) {
      case StatusNotification.urgent:
        return 'urgent';
      case StatusNotification.normal:
        return 'normal';
      case StatusNotification.low:
        return 'low';
      default:
        return 'normal';
    }
  }
}
