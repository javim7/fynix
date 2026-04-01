import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_typography.dart';

/// Avatar with optional level badge overlay.
class FynixAvatar extends StatelessWidget {
  const FynixAvatar({
    super.key,
    this.imageUrl,
    this.displayName,
    required this.size,
    this.level,
    this.showLevelBadge = true,
    this.onTap,
  });

  final String? imageUrl;

  /// Used to generate initials if [imageUrl] is null.
  final String? displayName;
  final double size;
  final int? level;
  final bool showLevelBadge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badgeSize = size * 0.35;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _Avatar(
            imageUrl: imageUrl,
            displayName: displayName,
            size: size,
          ),
          if (showLevelBadge && level != null)
            Positioned(
              bottom: -4,
              right: -4,
              child: _LevelBadge(level: level!, size: badgeSize),
            ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    this.imageUrl,
    this.displayName,
    required this.size,
  });

  final String? imageUrl;
  final String? displayName;
  final double size;

  String get _initials {
    if (displayName == null || displayName!.isEmpty) return '?';
    final parts = displayName!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return displayName![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Gradient avatar skin when no real photo is set
        gradient: hasImage
            ? null
            : const LinearGradient(
                colors: [AppColors.aiAccent, AppColors.flameCoral],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        color: hasImage ? AppColors.ember : null,
        border: Border.all(color: AppColors.gold, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasImage
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.gold,
                ),
              ),
              errorWidget: (context, url, error) => _Initials(
                initials: _initials,
                size: size,
                onGradient: true,
              ),
            )
          : _Initials(initials: _initials, size: size, onGradient: true),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({
    required this.initials,
    required this.size,
    this.onGradient = false,
  });

  final String initials;
  final double size;
  final bool onGradient;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: AppTypography.h4.copyWith(
          fontSize: size * 0.35,
          color: onGradient ? AppColors.white : AppColors.gold,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level, required this.size});

  final int level;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.gold,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.obsidian, width: 1.5),
      ),
      child: Center(
        child: Text(
          '$level',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: size * 0.4,
            fontWeight: FontWeight.w700,
            color: AppColors.obsidian,
          ),
        ),
      ),
    );
  }
}
