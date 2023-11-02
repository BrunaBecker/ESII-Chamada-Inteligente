import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../../core/widgets/spacing.dart';

class StudentInfoJustification extends StatelessWidget {
  const StudentInfoJustification({
    super.key,
    required this.justification,
  });

  final Map<String, dynamic> justification;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          AppDateUtils.appDateFormat.format(justification["date"]),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          justification["title"],
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 16.0,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.attach_file_outlined,
                  color: AppColors.black,
                ),
                // TODO: get file name
                Text(
                  justification["attach_file"]?.name ?? "Sem anexo",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Text(
              justification["description"] ?? "-",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              bottom: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Não aceitar"),
                ),
                const Spacing(4.0),
                FilledButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.check_outlined,
                          size: 18,
                        ),
                      ),
                      Text("Aceitar"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
