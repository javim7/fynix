import 'package:flutter/material.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';

/// Standard Fynix card with press animation, hairline border, and optional gradient.
class FynixCard extends StatefulWidget {
  const FynixCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
    this.color = AppColors.darkEmber,
    this.borderRadius = AppSpacing.radiusLg,
    this.border,
    this.gradient,
    this.glowColor,
    this.showHairlineBorder = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color color;
  final double borderRadius;

  /// Explicit border — overrides [showHairlineBorder].
  final BoxBorder? border;

  /// Optional gradient fill — takes priority over [color].
  final Gradient? gradient;

  /// Optional glow color rendered as a box shadow.
  final Color? glowColor;

  /// When true and [border] is null, renders a subtle hairline border.
  final bool showHairlineBorder;

  @override
  State<FynixCard> createState() => _FynixCardState();
}

class _FynixCardState extends State<FynixCard> {
  bool _pressed = false;

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  BoxBorder? get _effectiveBorder {
    if (widget.border != null) return widget.border;
    if (widget.showHairlineBorder) {
      return Border.all(color: AppColors.borderHairline, width: 1);
    }
    return null;
  }

  List<BoxShadow>? get _shadows {
    if (widget.glowColor == null) return null;
    return [
      BoxShadow(
        color: widget.glowColor!.withAlpha(60),
        blurRadius: 14,
        spreadRadius: 0,
        offset: const Offset(0, 3),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.borderRadius);

    final decorated = Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.gradient == null ? widget.color : null,
        gradient: widget.gradient,
        borderRadius: radius,
        border: _effectiveBorder,
        boxShadow: _shadows,
      ),
      child: widget.child,
    );

    if (widget.onTap == null) return decorated;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: decorated,
      ),
    );
  }
}
