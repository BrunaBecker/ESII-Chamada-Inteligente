import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatter {
  const Formatter({
    required this.pattern,
    required this.filters,
  });

  final String pattern;
  final Map<String, RegExp> filters;
}

class MaskAdapter {
  MaskAdapter({
    required Formatter registration,
    required Formatter siape,
    required Formatter date,
    required Formatter time,
  })  : registration = MaskTextInputFormatter(
          mask: registration.pattern,
          filter: registration.filters,
        ),
        siape = MaskTextInputFormatter(
          mask: siape.pattern,
          filter: siape.filters,
        ),
        date = MaskTextInputFormatter(
          mask: date.pattern,
          filter: date.filters,
        ),
        time = MaskTextInputFormatter(
          mask: time.pattern,
          filter: time.filters,
        );

  final MaskTextInputFormatter registration;
  final MaskTextInputFormatter siape;
  final MaskTextInputFormatter date;
  final MaskTextInputFormatter time;
}
