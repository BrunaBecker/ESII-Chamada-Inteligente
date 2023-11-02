import 'package:flutter/material.dart';

import '../../../core/widgets/spacing.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
  });

  final bool value;
  final Function(bool) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
        ),
        const Spacing(4.0),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
