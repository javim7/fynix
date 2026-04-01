import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/services/health_sync_service.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  bool _isSyncing = false;
  HealthSyncResult? _lastResult;
  String? _error;

  Future<void> _sync() async {
    setState(() { _isSyncing = true; _error = null; _lastResult = null; });
    try {
      final service = ref.read(healthSyncServiceProvider);
      final result = await service.sync();
      setState(() { _lastResult = result; });
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _isSyncing = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sincronizar')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pulsing sync icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: _isSyncing ? AppColors.flameCoral : AppColors.gold,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (_isSyncing ? AppColors.flameCoral : AppColors.gold).withAlpha(80),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                _isSyncing ? Icons.sync_rounded : Icons.sync_rounded,
                color: AppColors.obsidian,
                size: 48,
              ),
            )
                .animate(target: _isSyncing ? 1 : 0)
                .rotate(duration: 1000.ms, curve: Curves.linear)
                .animate(onPlay: (c) => _isSyncing ? c.repeat() : null),
            const SizedBox(height: AppSpacing.xl),
            Text(
              _isSyncing ? 'Sincronizando...' : 'Sincronizar actividades',
              style: AppTypography.h2,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Importa tus últimos entrenamientos de Apple Health y Strava',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (_lastResult != null) ...[
              FynixCard(
                child: Column(
                  children: [
                    Text('Sincronización completada', style: AppTypography.h4),
                    const SizedBox(height: AppSpacing.sm),
                    Text('${_lastResult!.imported} nuevos • ${_lastResult!.duplicates} duplicados', style: AppTypography.bodySmall),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (_error != null) ...[
              FynixCard(
                border: Border.all(color: AppColors.error),
                child: Text('Error: $_error', style: AppTypography.bodySmall.copyWith(color: AppColors.error)),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            FynixButton(
              label: _isSyncing ? 'Sincronizando...' : 'Sincronizar ahora',
              onPressed: _isSyncing ? null : _sync,
              isLoading: _isSyncing,
            ),
          ],
        ),
      ),
    );
  }
}
