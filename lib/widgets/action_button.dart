import 'package:flutter/material.dart';

/// A circular floating action button used in the discovery controls
/// (rewind, nope, super-like, like, boost).
class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;
  final Gradient gradient;

  const ActionButton({
    Key key,
    this.icon,
    this.color,
    this.size = 56,
    this.onTap,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: gradient == null ? Colors.white : null,
          gradient: gradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (color ?? Colors.black).withOpacity(0.22),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: gradient == null ? color : Colors.white,
          size: size * 0.46,
        ),
      ),
    );
  }
}
