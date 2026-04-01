import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/workout.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/sport_icon.dart';

/// Three-step onboarding: sport selection → fitness level → city.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _step = 0;
  final Set<WorkoutSportType> _selectedSports = {};
  String _fitnessLevel = 'beginner';
  final _cityCtrl = TextEditingController();

  @override
  void dispose() {
    _cityCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      _finish();
    }
  }

  void _finish() {
    // TODO: save preferences to user profile
    context.go(Routes.feed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) => _Dot(active: i == _step)),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStep(),
                ),
              ),
              FynixButton(
                label: _step == 2 ? '¡Empezar!' : 'Continuar',
                onPressed: _next,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _SportSelectionStep(
          key: const ValueKey('sports'),
          selected: _selectedSports,
          onToggle: (sport) => setState(() {
            if (_selectedSports.contains(sport)) {
              _selectedSports.remove(sport);
            } else {
              _selectedSports.add(sport);
            }
          }),
        );
      case 1:
        return _FitnessLevelStep(
          key: const ValueKey('level'),
          selected: _fitnessLevel,
          onSelect: (level) => setState(() => _fitnessLevel = level),
        );
      case 2:
        return _CityStep(key: const ValueKey('city'), controller: _cityCtrl);
      default:
        return const SizedBox.shrink();
    }
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.gold : AppColors.ember,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _SportSelectionStep extends StatelessWidget {
  const _SportSelectionStep({
    super.key,
    required this.selected,
    required this.onToggle,
  });

  final Set<WorkoutSportType> selected;
  final ValueChanged<WorkoutSportType> onToggle;

  @override
  Widget build(BuildContext context) {
    final sports = WorkoutSportType.values
        .where((s) => s != WorkoutSportType.other)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('¿Qué deportes practicas?', style: AppTypography.h2),
        const SizedBox(height: AppSpacing.xs),
        Text('Selecciona todos los que apliquen', style: AppTypography.bodySmall),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 1.0,
            ),
            itemCount: sports.length,
            itemBuilder: (context, i) {
              final sport = sports[i];
              final isSelected = selected.contains(sport);
              return GestureDetector(
                onTap: () => onToggle(sport),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.darkEmber : AppColors.darkEmber.withAlpha(128),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(
                      color: isSelected ? AppColors.gold : AppColors.ember,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SportIcon(
                        sport: sport,
                        color: isSelected ? AppColors.gold : AppColors.midGray,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        SportIcon.labelFor(sport),
                        style: AppTypography.labelSmall.copyWith(
                          color: isSelected ? AppColors.gold : AppColors.midGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FitnessLevelStep extends StatelessWidget {
  const _FitnessLevelStep({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    const levels = [
      ('beginner', 'Principiante', 'Comienzo desde cero o llevo poco tiempo entrenando'),
      ('intermediate', 'Intermedio', 'Llevo 6+ meses entrenando regularmente'),
      ('advanced', 'Avanzado', 'Entreno 5+ veces por semana y compito'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('¿Cuál es tu nivel?', style: AppTypography.h2),
        const SizedBox(height: AppSpacing.xs),
        Text('Esto nos ayuda a personalizar tus desafíos', style: AppTypography.bodySmall),
        const SizedBox(height: AppSpacing.lg),
        ...levels.map(
          (level) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: GestureDetector(
              onTap: () => onSelect(level.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.darkEmber,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(
                    color: selected == level.$1 ? AppColors.gold : AppColors.ember,
                    width: selected == level.$1 ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      selected == level.$1
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selected == level.$1 ? AppColors.gold : AppColors.midGray,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(level.$2, style: AppTypography.h4),
                          Text(level.$3, style: AppTypography.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CityStep extends StatelessWidget {
  const _CityStep({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('¿En qué ciudad entrenas?', style: AppTypography.h2),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Úsalo para encontrar eventos y atletas cerca de ti',
          style: AppTypography.bodySmall,
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: controller,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Ciudad de Guatemala',
            hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.midGray),
            filled: true,
            fillColor: AppColors.surface2,
            prefixIcon: const Icon(Icons.location_on_rounded, color: AppColors.gold),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(color: AppColors.borderHairline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(color: AppColors.gold, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
        ),
      ],
    );
  }
}
