import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../theme/colors.dart';
import 'profile_photo.dart';

/// The card face shown in the deck: photo, progress bars for multiple photos,
/// a readable scrim, the person's details and interest chips.
class ProfileCard extends StatefulWidget {
  final Profile profile;

  const ProfileCard({Key key, this.profile}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  int _photoIndex = 0;

  List<String> get _photos => widget.profile.photos ?? const [];

  void _tapPhoto(TapUpDetails details, double width) {
    if (_photos.length < 2) return;
    final goNext = details.localPosition.dx > width / 2;
    setState(() {
      if (goNext) {
        _photoIndex = (_photoIndex + 1) % _photos.length;
      } else {
        _photoIndex = (_photoIndex - 1 + _photos.length) % _photos.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profile;
    final photo = _photos.isNotEmpty ? _photos[_photoIndex] : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: GestureDetector(
            onTapUp: (d) => _tapPhoto(d, constraints.maxWidth),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ProfilePhoto(url: photo, initial: p.name),
                const DecoratedBox(
                  decoration: BoxDecoration(gradient: AppColors.photoScrim),
                ),
                if (_photos.length > 1) _photoBars(),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 22,
                  child: _details(p),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _photoBars() {
    return Positioned(
      top: 14,
      left: 14,
      right: 14,
      child: Row(
        children: List.generate(_photos.length, (i) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 4,
              decoration: BoxDecoration(
                color: i == _photoIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.35),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _details(Profile p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: Text(
                p.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${p.age ?? ''}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w300,
              ),
            ),
            if (p.likesYou) ...[
              const SizedBox(width: 10),
              _likesYouBadge(),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.work_outline, size: 16, color: Colors.white70),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                p.job ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 16, color: Colors.white70),
            const SizedBox(width: 6),
            Text(
              p.distance ?? '',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
        if (p.interests != null && p.interests.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: p.interests
                .take(4)
                .map((tag) => _interestChip(tag))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _likesYouBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.star, size: 12, color: Colors.white),
          SizedBox(width: 3),
          Text(
            'LIKES YOU',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _interestChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
