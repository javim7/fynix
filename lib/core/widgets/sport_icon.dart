import 'package:flutter/material.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/models/workout.dart';

/// Maps a [WorkoutSportType] to a Material icon.
class SportIcon extends StatelessWidget {
  const SportIcon({
    super.key,
    required this.sport,
    this.size = 24.0,
    this.color = AppColors.gold,
  });

  final WorkoutSportType sport;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(_iconFor(sport), size: size, color: color);
  }

  static IconData _iconFor(WorkoutSportType sport) {
    switch (sport) {
      case WorkoutSportType.running:
        return Icons.directions_run_rounded;
      case WorkoutSportType.cycling:
        return Icons.directions_bike_rounded;
      case WorkoutSportType.swimming:
        return Icons.pool_rounded;
      case WorkoutSportType.walking:
        return Icons.directions_walk_rounded;
      case WorkoutSportType.hiking:
        return Icons.terrain_rounded;
      case WorkoutSportType.strength:
        return Icons.fitness_center_rounded;
      case WorkoutSportType.yoga:
        return Icons.self_improvement_rounded;
      case WorkoutSportType.crossfit:
        return Icons.sports_gymnastics_rounded;
      case WorkoutSportType.triathlon:
        return Icons.emoji_events_rounded;
      case WorkoutSportType.other:
        return Icons.sports_rounded;
    }
  }

  /// Spanish display name for each sport.
  static String labelFor(WorkoutSportType sport) {
    switch (sport) {
      case WorkoutSportType.running:
        return 'Carrera';
      case WorkoutSportType.cycling:
        return 'Ciclismo';
      case WorkoutSportType.swimming:
        return 'Natación';
      case WorkoutSportType.walking:
        return 'Caminata';
      case WorkoutSportType.hiking:
        return 'Senderismo';
      case WorkoutSportType.strength:
        return 'Fuerza';
      case WorkoutSportType.yoga:
        return 'Yoga';
      case WorkoutSportType.crossfit:
        return 'CrossFit';
      case WorkoutSportType.triathlon:
        return 'Triatlón';
      case WorkoutSportType.other:
        return 'Otro';
    }
  }
}
