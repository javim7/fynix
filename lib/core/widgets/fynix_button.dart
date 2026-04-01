import 'package:flutter/material.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';

/// Button variant.
enum FynixButtonVariant { primary, secondary, ghost }

/// Fynix design-system button with three variants:
/// - **primary** — Gold background, Obsidian text, gold glow shadow
/// - **secondary** — outlined Gold border, Gold text
/// - **ghost** — no border, Honey text
///
/// All variants animate with a subtle scale-down on press (0.97×).
class FynixButton extends StatefulWidget {
  const FynixButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = FynixButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final FynixButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  @override
  State<FynixButton> createState() => _FynixButtonState();
}

class _FynixButtonState extends State<FynixButton> {
  bool _pressed = false;

  bool get _isDisabled => widget.isLoading || widget.onPressed == null;

  Size get _minSize => widget.isFullWidth
      ? const Size(double.infinity, 52)
      : const Size(0, 52);

  Widget get _child => widget.isLoading
      ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: widget.variant == FynixButtonVariant.primary
                ? AppColors.obsidian
                : AppColors.gold,
          ),
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: AppSpacing.iconSm),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(widget.label),
          ],
        );

  Widget _buildButton() {
    switch (widget.variant) {
      case FynixButtonVariant.primary:
        // Wrap in AnimatedContainer to animate the gold glow in/out
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            boxShadow: _isDisabled || _pressed
                ? null
                : const [
                    BoxShadow(
                      color: AppColors.goldGlow,
                      blurRadius: 18,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: ElevatedButton(
            onPressed: _isDisabled ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: _minSize,
              textStyle: AppTypography.button,
            ),
            child: _child,
          ),
        );

      case FynixButtonVariant.secondary:
        return OutlinedButton(
          onPressed: _isDisabled ? null : widget.onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: _minSize,
            textStyle: AppTypography.button,
          ),
          child: _child,
        );

      case FynixButtonVariant.ghost:
        return TextButton(
          onPressed: _isDisabled ? null : widget.onPressed,
          style: TextButton.styleFrom(
            minimumSize: _minSize,
            foregroundColor: AppColors.honey,
            textStyle: AppTypography.button.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          child: _child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed && !_isDisabled ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: _buildButton(),
      ),
    );
  }
}
