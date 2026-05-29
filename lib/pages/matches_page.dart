import 'package:flutter/material.dart';
import '../data/match_store.dart';
import '../theme/colors.dart';
import '../widgets/profile_photo.dart';
import 'chat_page.dart';

/// Shows new matches in a horizontal rail and conversations below — the
/// classic dating-app "Matches + Messages" layout.
class MatchesPage extends StatelessWidget {
  const MatchesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<List<Match>>(
        valueListenable: MatchStore.instance.matches,
        builder: (context, matches, _) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: _Title()),
              if (matches.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyMatches(),
                )
              else ...[
                SliverToBoxAdapter(child: _NewMatchesRail(matches: matches)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _ConversationTile(match: matches[i]),
                    childCount: matches.length,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        'Matches',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _NewMatchesRail extends StatelessWidget {
  final List<Match> matches;
  const _NewMatchesRail({Key key, this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: matches.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final m = matches[i];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ChatPage(match: m)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: m.isNew ? AppColors.flameGradient : null,
                    color: m.isNew ? null : AppColors.divider,
                  ),
                  child: Container(
                    width: 66,
                    height: 66,
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: ProfilePhoto(
                        url: m.profile.heroPhoto,
                        initial: m.profile.name,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 70,
                  child: Text(
                    m.profile.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Match match;
  const _ConversationTile({Key key, this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = match.profile;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(child: ProfilePhoto(url: p.heroPhoto, initial: p.name)),
      ),
      title: Text(
        p.name ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        match.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: match.isNew
          ? Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                gradient: AppColors.flameGradient,
                shape: BoxShape.circle,
              ),
            )
          : null,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ChatPage(match: match)),
      ),
    );
  }
}

class _EmptyMatches extends StatelessWidget {
  const _EmptyMatches({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (r) => AppColors.flameGradient.createShader(r),
              child: const Icon(Icons.favorite_border,
                  size: 72, color: Colors.white),
            ),
            const SizedBox(height: 18),
            const Text(
              'No matches yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start swiping to find your spark.\nWhen you both like each other, they show up here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
