import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../theme/colors.dart';
import '../widgets/profile_photo.dart';

/// Full-screen celebration shown when a swipe results in a mutual match.
class MatchOverlay extends StatefulWidget {
  final Profile profile;
  final String currentUserName;
  final VoidCallback onSendMessage;

  const MatchOverlay({
    Key key,
    this.profile,
    this.currentUserName = 'You',
    this.onSendMessage,
  }) : super(key: key);

  static Future<void> show(BuildContext context, Profile profile,
      {VoidCallback onSendMessage}) {
    return Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) =>
          MatchOverlay(profile: profile, onSendMessage: onSendMessage),
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
    ));
  }

  @override
  _MatchOverlayState createState() => _MatchOverlayState();
}

class _MatchOverlayState extends State<MatchOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _avatar(String url, String initial, Alignment slideFrom) {
    final slide = Tween<Offset>(
      begin: Offset(slideFrom.x * 0.6, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutBack));
    return SlideTransition(
      position: slide,
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 18, offset: Offset(0, 8)),
          ],
        ),
        child: ClipOval(child: ProfilePhoto(url: url, initial: initial)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profile;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.flameGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                FadeTransition(
                  opacity: _c,
                  child: ShaderMask(
                    shaderCallback: (r) => const LinearGradient(
                      colors: [Colors.white, Color(0xFFFFE3EC)],
                    ).createShader(r),
                    child: const Text(
                      "It's a Match!",
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'You and ${p.name} have liked each other.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 44),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _avatar(p.heroPhoto, p.name, Alignment.centerLeft),
                    const SizedBox(width: 18),
                    _avatar(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=400&q=80',
                      widget.currentUserName,
                      Alignment.centerRight,
                    ),
                  ],
                ),
                const Spacer(),
                _primaryButton(
                  label: 'Send a message',
                  onTap: () {
                    Navigator.of(context).pop();
                    if (widget.onSendMessage != null) widget.onSendMessage();
                  },
                ),
                const SizedBox(height: 14),
                _secondaryButton(
                  label: 'Keep swiping',
                  onTap: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _primaryButton({String label, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Send a message',
          style: TextStyle(
            color: AppColors.flameEnd,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _secondaryButton({String label, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white70, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
