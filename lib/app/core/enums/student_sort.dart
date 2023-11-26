enum StudentSort {
  alphabetical,
  presence,
  absence,
  justification;

  String toLongString() {
    switch (this) {
      case StudentSort.alphabetical:
        return "Alfabeticamente";
      case StudentSort.presence:
        return "Presença";
      case StudentSort.absence:
        return "Falta";
      case StudentSort.justification:
        return "Falta abonada";
      default:
        return "";
    }
  }
}
