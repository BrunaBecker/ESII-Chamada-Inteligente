import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/spacing.dart';
import '../attendance_info_controller.dart';

class AttendanceInfoBottomSheet extends StatelessWidget {
  const AttendanceInfoBottomSheet({
    super.key,
    this.title = "",
    this.initialTab = 0,
  });

  final String title;
  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceInfoController>(
      builder: (controller) => Obx(
        () => SizedBox(
          child: DefaultTabController(
            length: 3,
            initialIndex: initialTab,
            child: Center(
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.filter_alt_outlined),
                            Spacing(4.0),
                            Text("Filtrar"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.download_outlined),
                            Spacing(4.0),
                            Text("Exportar"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.sort_by_alpha_outlined),
                            Spacing(4.0),
                            Text("Ordenar"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: controller.filters.length,
                          itemBuilder: (context, index) {
                            final key = controller.filters.keys.toList()[index];
                            return ListTile(
                              leading: Checkbox(
                                tristate: true,
                                value: controller.filters[key],
                                onChanged: (value) {
                                  controller.toggleFilter(
                                    newFilter: key,
                                  );
                                },
                              ),
                              title: Text(key.toLongString()),
                              onTap: () {
                                controller.toggleFilter(
                                  newFilter: key,
                                );
                              },
                            );
                          },
                        ),
                        ListView(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.upload_file_outlined),
                              title: const Text(
                                  "Exportar em Formato Excel (XLSX)"),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.difference_outlined),
                              title: const Text("Exportar em CSV"),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.mail_outlined),
                              title: const Text(
                                  "Enviar para email em Formato Excel"),
                              onTap: () {},
                            ),
                          ],
                        ),
                        ListView.builder(
                          itemCount: controller.sortOptions.length,
                          itemBuilder: (context, index) {
                            final sortOption = controller.sortOptions[index];
                            return ListTile(
                              leading: Icon(
                                sortOption == controller.sortMode
                                    ? controller.isAscending
                                        ? Icons.arrow_upward_outlined
                                        : Icons.arrow_downward_outlined
                                    : null,
                              ),
                              title: Text(sortOption.toLongString()),
                              onTap: () {
                                controller.changeSortMode(
                                  newSortMode: sortOption,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
