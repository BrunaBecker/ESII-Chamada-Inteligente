import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  const Spacing(this.padding, {super.key});

  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
    );
  }
}
