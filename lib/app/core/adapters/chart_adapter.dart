import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../domain/entities/attendance_entity.dart';
import '../theme/app_colors.dart';
import '../utils/app_date_utils.dart';

class ChartAdapter {
  Widget createAttendanceChart({
    required List<AttendanceEntity> data,
  }) =>
      SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: CategoryAxis(
          minimum: 0,
          maximum: 240,
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          enableDoubleTapZooming: true,
          maximumZoomLevel: 0.5,
          zoomMode: ZoomMode.x,
        ),
        series: [
          LineSeries(
            dataSource: data,
            xValueMapper: (attendance, _) => AppDateUtils.appDateFormat
                .format(attendance.date)
                .substring(0, 5),
            yValueMapper: (attendance, _) =>
                AppDateUtils.parseJavaDuration(attendance.duration).inMinutes,
            color: AppColors.primary,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 10,
              width: 10,
              borderWidth: 2,
            ),
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          builder: (data, point, series, pointIndex, seriesIndex) => Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aula: ${point.x}",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Tempo médio: ${point.y} minutos",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Alunos: ${data["total_students"]}",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
