enum Mask {
  registration,
  siape,
  date,
  time;

  String pattern() {
    switch (this) {
      case Mask.registration:
        return "#########";
      case Mask.siape:
        return "#######";
      case Mask.date:
        return "##/##/####";
      case Mask.time:
        return "##:##";
    }
  }

  Map<String, RegExp> filters() {
    switch (this) {
      case Mask.registration:
        return {
          "#": RegExp(r"[0-9]"),
        };
      case Mask.siape:
        return {
          "#": RegExp(r"[0-9]"),
        };
      case Mask.date:
        return {
          "#": RegExp(r"[0-9]"),
        };
      case Mask.time:
        return {
          "#": RegExp(r"[0-9]"),
        };
    }
  }
}
