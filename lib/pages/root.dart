import 'package:flutter/material.dart';
import '../data/match_store.dart';
import '../theme/colors.dart';
import 'discover_page.dart';
import 'matches_page.dart';
import 'profile_page.dart';

/// Hosts the three primary tabs with a custom bottom navigation bar.
class Root extends StatefulWidget {
  const Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _index = 0;

  final List<Widget> _pages = const [
    DiscoverPage(),
    MatchesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: _navBar(),
    );
  }

  Widget _navBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.local_fire_department, 'Discover'),
              _navItemWithBadge(1, Icons.favorite, 'Matches'),
              _navItem(2, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final selected = _index == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _index = index),
        child: _iconColumn(icon, label, selected),
      ),
    );
  }

  Widget _navItemWithBadge(int index, IconData icon, String label) {
    final selected = _index == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _index = index),
        child: ValueListenableBuilder<List<Match>>(
          valueListenable: MatchStore.instance.matches,
          builder: (context, matches, _) {
            final newCount = matches.where((m) => m.isNew).length;
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                _iconColumn(icon, label, selected),
                if (newCount > 0)
                  Positioned(
                    right: 22,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      constraints:
                          const BoxConstraints(minWidth: 18, minHeight: 18),
                      decoration: const BoxDecoration(
                        gradient: AppColors.flameGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$newCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _iconColumn(IconData icon, String label, bool selected) {
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 26, color: selected ? null : AppColors.textSecondary),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppColors.flameEnd : AppColors.textSecondary,
          ),
        ),
      ],
    );

    if (!selected) return content;
    // Tint the selected icon with the brand gradient.
    return ShaderMask(
      shaderCallback: (r) => AppColors.flameGradient.createShader(r),
      blendMode: BlendMode.srcIn,
      child: content,
    );
  }
}
