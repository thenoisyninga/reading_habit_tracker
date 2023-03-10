import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ReadingHabbitHeatmapCalendar extends StatefulWidget {
  const ReadingHabbitHeatmapCalendar({super.key, required this.datasets});
  final Map<DateTime, int> datasets;

  @override
  State<ReadingHabbitHeatmapCalendar> createState() => _ReadingHabbitHeatmapCalendarState();
}

class _ReadingHabbitHeatmapCalendarState extends State<ReadingHabbitHeatmapCalendar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: HeatMapCalendar(
        colorMode: ColorMode.color,
        colorsets: {
          1: Theme.of(context).colorScheme.primary.withOpacity(0.0),
          2: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          3: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          4: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          5: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          6: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          7: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          8: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          9: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          10: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        },
        textColor: Theme.of(context).scaffoldBackgroundColor,
        showColorTip: false,
        datasets: widget.datasets,
        size: 40,
        fontSize: 10,
        weekTextColor: Colors.white,
        // defaultColor: Colors.grey[200],
        onClick: (DateTime date) {},
      ),
    );
  }
}
