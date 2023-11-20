enum EventStatus {
  classNormal,
  classCancelled,
  classNormalRecurrent;

  String toLongText() {
    switch (this) {
      case EventStatus.classNormal:
        return "Aula normal";
      case EventStatus.classCancelled:
        return "Sem aula";
      case EventStatus.classNormalRecurrent:
        return "Aula com chamada recorrente";
    }
  }

  factory EventStatus.fromLongText(String text) {
    switch (text) {
      case "Aula normal":
        return EventStatus.classNormal;
      case "Sem aula":
        return EventStatus.classCancelled;
      case "Aula com chamada recorrente":
        return EventStatus.classNormalRecurrent;
      default:
        return EventStatus.classNormal;
    }
  }

  String toText() {
    switch (this) {
      case EventStatus.classNormal:
        return "classNormal";
      case EventStatus.classCancelled:
        return "classCancelled";
      case EventStatus.classNormalRecurrent:
        return "classNormalRecurrent";
    }
  }

  static fromText(String text) {
    switch (text) {
      case "classNormal":
        return EventStatus.classNormal;
      case "classCancelled":
        return EventStatus.classCancelled;
      case "classNormalRecurrent":
        return EventStatus.classNormalRecurrent;
      default:
        return EventStatus.classNormal;
    }
  }
}
