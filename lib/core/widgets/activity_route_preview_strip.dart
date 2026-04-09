import 'package:flutter/material.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';

/// Decorative “route” strip for activity cards — suggests GPS without embedding Mapbox.
/// Use full map + polyline in workout detail / “Ver todo”, not in tight list rows.
class ActivityRoutePreviewStrip extends StatelessWidget {
  const ActivityRoutePreviewStrip({
    super.key,
    required this.accentColor,
    this.showMapHint = true,
    this.height = 56,
  });

  final Color accentColor;
  final bool showMapHint;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: SizedBox(
            height: height,
            child: CustomPaint(
              foregroundPainter: _RouteSilhouettePainter(accent: accentColor),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surface2,
                      AppColors.darkEmber,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showMapHint) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.map_rounded,
                size: 12,
                color: AppColors.midGray.withAlpha(200),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Vista de ruta · mapa interactivo en el detalle',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.midGray,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _RouteSilhouettePainter extends CustomPainter {
  _RouteSilhouettePainter({required this.accent});

  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final glow = Paint()
      ..color = accent.withAlpha(35)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final line = Paint()
      ..color = accent.withAlpha(220)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(10, h * 0.62)
      ..quadraticBezierTo(w * 0.22, h * 0.18, w * 0.42, h * 0.48)
      ..quadraticBezierTo(w * 0.58, h * 0.72, w * 0.78, h * 0.32)
      ..quadraticBezierTo(w * 0.88, h * 0.18, w - 10, h * 0.45);

    canvas.drawPath(path, glow);
    canvas.drawPath(path, line);

    final dot = Paint()..color = accent.withAlpha(240);
    canvas.drawCircle(Offset(10, h * 0.62), 3.5, dot);
    canvas.drawCircle(Offset(w - 10, h * 0.45), 3, dot);
  }

  @override
  bool shouldRepaint(covariant _RouteSilhouettePainter oldDelegate) =>
      oldDelegate.accent != accent;
}
