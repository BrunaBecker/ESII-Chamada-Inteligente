import 'package:flutter/material.dart';

import '../../../core/widgets/spacing.dart';
import 'attendance_form.dart';
import 'attendance_settings_title.dart';
import 'attendance_start_button.dart';
import 'attendance_use_preset_button.dart';

class AttendanceCreationPanel extends StatelessWidget {
  const AttendanceCreationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: AttendanceSettingsTitle(),
          toolbarHeight: 135,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: AttendanceUsePresetButton(),
                    ),
                    Column(
                      children: [
                        AttendanceForm(),
                        Spacing(4.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AttendanceStartButton(
                            key: Key('start roll call button'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
