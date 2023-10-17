enum PresenceStatus {
  present,
  absent,
  absentJustified;

  static PresenceStatus? fromInt(int value) {
    switch (value) {
      case 0:
        return PresenceStatus.present;
      case 1:
        return PresenceStatus.absent;
      case 2:
        return PresenceStatus.absentJustified;
      default:
        return null;
    }
  }

  int toInt() {
    switch (this) {
      case PresenceStatus.present:
        return 0;
      case PresenceStatus.absent:
        return 1;
      case PresenceStatus.absentJustified:
        return 2;
    }
  }
}
