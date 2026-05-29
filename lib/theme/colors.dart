import 'package:flutter/material.dart';

/// Spark brand palette — warm, energetic gradients inspired by a sunset flame.
class AppColors {
  AppColors._();

  // Primary brand gradient (the "Spark" flame).
  static const Color flameStart = Color(0xFFFF7854); // warm coral
  static const Color flameEnd = Color(0xFFFD267D); // hot pink

  // Accent gradient used for super-likes / highlights.
  static const Color accentStart = Color(0xFF2EC4FF);
  static const Color accentEnd = Color(0xFF1F6FFF);

  static const Color like = Color(0xFF36D1A0);
  static const Color nope = Color(0xFFFF5864);
  static const Color superLike = Color(0xFF1EC8F0);

  static const Color background = Color(0xFFF6F6F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF20242E);
  static const Color textSecondary = Color(0xFF8B8F9A);
  static const Color divider = Color(0xFFEDEEF2);

  static const LinearGradient flameGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [flameStart, flameEnd],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentStart, accentEnd],
  );

  /// Dark scrim drawn over the bottom of a photo so text stays readable.
  static const LinearGradient photoScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x00000000),
      Color(0x33000000),
      Color(0xCC000000),
    ],
    stops: [0.45, 0.7, 1.0],
  );
}
