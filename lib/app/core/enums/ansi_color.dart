enum AnsiColor {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  lightBlack,
  lightRed,
  lightGreen,
  lightYellow,
  lightBlue,
  lightMagenta,
  lightCyan,
  lightWhite;

  int get code {
    switch (this) {
      case AnsiColor.black:
        return 30;
      case AnsiColor.red:
        return 31;
      case AnsiColor.green:
        return 32;
      case AnsiColor.yellow:
        return 33;
      case AnsiColor.blue:
        return 34;
      case AnsiColor.magenta:
        return 35;
      case AnsiColor.cyan:
        return 36;
      case AnsiColor.white:
        return 37;
      case AnsiColor.lightBlack:
        return 90;
      case AnsiColor.lightRed:
        return 91;
      case AnsiColor.lightGreen:
        return 92;
      case AnsiColor.lightYellow:
        return 93;
      case AnsiColor.lightBlue:
        return 94;
      case AnsiColor.lightMagenta:
        return 95;
      case AnsiColor.lightCyan:
        return 96;
      case AnsiColor.lightWhite:
        return 97;
    }
  }
}
