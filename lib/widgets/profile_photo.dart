import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// Displays a network photo with a graceful branded fallback while loading or
/// when the device is offline, so cards never show a broken-image box.
class ProfilePhoto extends StatelessWidget {
  final String url;
  final String initial;

  const ProfilePhoto({Key key, this.url, this.initial}) : super(key: key);

  Widget _fallback() {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.flameGradient),
      alignment: Alignment.center,
      child: Text(
        (initial ?? '?').toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 96,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (url == null || url.isEmpty) return _fallback();
    return Image.network(
      url,
      fit: BoxFit.cover,
      gaplessPlayback: true,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          decoration: const BoxDecoration(gradient: AppColors.flameGradient),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 34,
            height: 34,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stack) => _fallback(),
    );
  }
}
