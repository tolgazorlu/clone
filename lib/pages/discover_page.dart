import 'package:flutter/material.dart';
import '../data/match_store.dart';
import '../data/profiles.dart';
import '../models/profile.dart';
import '../theme/colors.dart';
import '../widgets/action_button.dart';
import '../widgets/draggable_card.dart';
import '../widgets/profile_card.dart';
import 'chat_page.dart';
import 'match_overlay.dart';

/// The swipe deck — the heart of the app.
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<Profile> _deck;
  final List<Profile> _history = []; // for rewind
  GlobalKey<DraggableCardState> _topKey;

  @override
  void initState() {
    super.initState();
    _deck = List<Profile>.from(sampleProfiles);
    _topKey = GlobalKey<DraggableCardState>();
  }

  void _onSwiped(SwipeDirection direction) {
    if (_deck.isEmpty) return;
    final swiped = _deck.first;
    setState(() {
      _history.add(swiped);
      _deck.removeAt(0);
      _topKey = GlobalKey<DraggableCardState>();
    });

    final liked =
        direction == SwipeDirection.like || direction == SwipeDirection.superLike;
    if (liked && swiped.likesYou) {
      MatchStore.instance.add(swiped);
      MatchOverlay.show(
        context,
        swiped,
        onSendMessage: () {
          final match = MatchStore.instance.matches.value.firstWhere(
            (m) => m.profile.id == swiped.id,
            orElse: () => null,
          );
          if (match != null) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ChatPage(match: match)),
            );
          }
        },
      );
    }
  }

  void _swipeTop(SwipeDirection direction) {
    _topKey.currentState?.triggerSwipe(direction);
  }

  void _rewind() {
    if (_history.isEmpty) return;
    setState(() {
      _deck.insert(0, _history.removeLast());
      _topKey = GlobalKey<DraggableCardState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          _header(),
          Expanded(child: _deckArea()),
          _controls(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (r) => AppColors.flameGradient.createShader(r),
            child: const Icon(Icons.local_fire_department,
                color: Colors.white, size: 34),
          ),
          const SizedBox(width: 6),
          ShaderMask(
            shaderCallback: (r) => AppColors.flameGradient.createShader(r),
            child: const Text(
              'spark',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Spacer(),
          Icon(Icons.tune, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _deckArea() {
    if (_deck.isEmpty) return _emptyState();

    // Render at most 3 cards; the front one is interactive.
    final visible = _deck.take(3).toList();
    final cards = <Widget>[];
    for (int i = visible.length - 1; i >= 0; i--) {
      final isFront = i == 0;
      final scale = 1.0 - (i * 0.04);
      final translateY = i * 12.0;
      cards.add(
        Positioned.fill(
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: Transform.scale(
              scale: scale,
              child: DraggableCard(
                key: isFront ? _topKey : ValueKey(visible[i].id),
                isFront: isFront,
                onSwiped: isFront ? _onSwiped : null,
                child: _cardShell(ProfileCard(
                  key: ValueKey(visible[i].id),
                  profile: visible[i],
                )),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Stack(children: cards),
    );
  }

  Widget _cardShell(Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (r) => AppColors.flameGradient.createShader(r),
              child: const Icon(Icons.favorite,
                  size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              "You're all caught up!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'No more people nearby right now.\nCheck back soon for new sparks.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => setState(() {
                _deck = List<Profile>.from(sampleProfiles);
                _history.clear();
                _topKey = GlobalKey<DraggableCardState>();
              }),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                decoration: BoxDecoration(
                  gradient: AppColors.flameGradient,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Start over',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controls() {
    final enabled = _deck.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionButton(
            icon: Icons.refresh,
            color: const Color(0xFFF7B500),
            size: 46,
            onTap: _history.isEmpty ? null : _rewind,
          ),
          const SizedBox(width: 14),
          ActionButton(
            icon: Icons.close,
            color: AppColors.nope,
            size: 60,
            onTap: enabled ? () => _swipeTop(SwipeDirection.nope) : null,
          ),
          const SizedBox(width: 14),
          ActionButton(
            icon: Icons.star,
            color: AppColors.superLike,
            size: 50,
            onTap: enabled ? () => _swipeTop(SwipeDirection.superLike) : null,
          ),
          const SizedBox(width: 14),
          ActionButton(
            icon: Icons.favorite,
            color: AppColors.like,
            size: 60,
            onTap: enabled ? () => _swipeTop(SwipeDirection.like) : null,
          ),
          const SizedBox(width: 14),
          ActionButton(
            icon: Icons.bolt,
            gradient: AppColors.accentGradient,
            size: 46,
            onTap: enabled ? () => _swipeTop(SwipeDirection.superLike) : null,
          ),
        ],
      ),
    );
  }
}
