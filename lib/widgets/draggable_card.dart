import 'package:flutter/material.dart';
import '../theme/colors.dart';

enum SwipeDirection { like, nope, superLike }

/// A card the user can fling left (nope), right (like) or up (super like).
/// Drag thresholds trigger a swipe; otherwise the card springs back. Callers
/// can also drive it programmatically via a [GlobalKey] and [triggerSwipe].
class DraggableCard extends StatefulWidget {
  final Widget child;
  final bool isFront;
  final ValueChanged<SwipeDirection> onSwiped;

  const DraggableCard({
    Key key,
    this.child,
    this.isFront = false,
    this.onSwiped,
  }) : super(key: key);

  @override
  DraggableCardState createState() => DraggableCardState();
}

class DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  Offset _drag = Offset.zero;
  Size _size = Size.zero;

  AnimationController _controller;
  Animation<Offset> _animation;
  SwipeDirection _pendingExit;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(() {
        setState(() => _drag = _animation.value);
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          final exit = _pendingExit;
          _pendingExit = null;
          if (exit != null && widget.onSwiped != null) {
            widget.onSwiped(exit);
          }
          _drag = Offset.zero;
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---- Drag handling -------------------------------------------------------

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() => _drag += details.delta);
  }

  void _onEnd(DragEndDetails details) {
    final width = _size.width == 0 ? 360 : _size.width;
    final dx = _drag.dx;
    final dy = _drag.dy;
    final velocity = details.velocity.pixelsPerSecond;

    if (dy < -width * 0.45 || velocity.dy < -1200) {
      _flingOut(SwipeDirection.superLike);
    } else if (dx > width * 0.28 || velocity.dx > 800) {
      _flingOut(SwipeDirection.like);
    } else if (dx < -width * 0.28 || velocity.dx < -800) {
      _flingOut(SwipeDirection.nope);
    } else {
      _springBack();
    }
  }

  void _springBack() {
    _animation = Tween<Offset>(begin: _drag, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _pendingExit = null;
    _controller
      ..reset()
      ..forward();
  }

  void _flingOut(SwipeDirection direction) {
    final w = _size.width == 0 ? 360.0 : _size.width;
    final h = _size.height == 0 ? 640.0 : _size.height;
    Offset target;
    switch (direction) {
      case SwipeDirection.like:
        target = Offset(w * 1.6, _drag.dy);
        break;
      case SwipeDirection.nope:
        target = Offset(-w * 1.6, _drag.dy);
        break;
      case SwipeDirection.superLike:
        target = Offset(_drag.dx, -h * 1.6);
        break;
    }
    _animation = Tween<Offset>(begin: _drag, end: target)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _pendingExit = direction;
    _controller
      ..reset()
      ..forward();
  }

  /// Programmatic swipe used by the action buttons.
  void triggerSwipe(SwipeDirection direction) {
    if (_controller.isAnimating) return;
    _flingOut(direction);
  }

  // ---- Visual helpers ------------------------------------------------------

  double get _rotation {
    final double w = _size.width == 0 ? 360.0 : _size.width;
    return (_drag.dx / w) * 0.4; // up to ~0.4 rad
  }

  double _likeOpacity() => _size.width == 0
      ? 0.0
      : (_drag.dx / (_size.width * 0.28)).clamp(0.0, 1.0).toDouble();
  double _nopeOpacity() => _size.width == 0
      ? 0.0
      : (-_drag.dx / (_size.width * 0.28)).clamp(0.0, 1.0).toDouble();
  double _superOpacity() => _size.height == 0
      ? 0.0
      : (-_drag.dy / (_size.height * 0.25)).clamp(0.0, 1.0).toDouble();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = Size(constraints.maxWidth, constraints.maxHeight);
        final card = Transform.translate(
          offset: _drag,
          child: Transform.rotate(
            angle: _rotation,
            child: Stack(
              fit: StackFit.expand,
              children: [
                widget.child,
                if (widget.isFront) ...[
                  _stamp('LIKE', AppColors.like, _likeOpacity(),
                      Alignment.topLeft, -0.4),
                  _stamp('NOPE', AppColors.nope, _nopeOpacity(),
                      Alignment.topRight, 0.4),
                  _stamp('SUPER\nLIKE', AppColors.superLike, _superOpacity(),
                      Alignment.bottomCenter, -0.2),
                ],
              ],
            ),
          ),
        );

        if (!widget.isFront) return card;

        return GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onEnd,
          child: card,
        );
      },
    );
  }

  Widget _stamp(
      String text, Color color, double opacity, Alignment align, double angle) {
    return Align(
      alignment: align,
      child: Padding(
        padding: const EdgeInsets.all(34),
        child: Opacity(
          opacity: opacity,
          child: Transform.rotate(
            angle: angle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 36,
                  height: 0.95,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
