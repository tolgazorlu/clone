import 'package:flutter/foundation.dart';
import '../models/profile.dart';

/// A mutual match plus a tiny bit of conversation state for the chat list.
class Match {
  final Profile profile;
  final DateTime matchedAt;
  String lastMessage;
  bool isNew;

  Match({this.profile, this.matchedAt, this.lastMessage = '', this.isNew = true});
}

/// Lightweight app-wide store for matches. Avoids pulling in a state-management
/// package — a [ValueNotifier] is enough for an app this size.
class MatchStore {
  MatchStore._();
  static final MatchStore instance = MatchStore._();

  final ValueNotifier<List<Match>> matches = ValueNotifier<List<Match>>([]);

  void add(Profile profile) {
    // Avoid duplicate matches for the same person.
    if (matches.value.any((m) => m.profile.id == profile.id)) return;
    final updated = List<Match>.from(matches.value)
      ..insert(
        0,
        Match(
          profile: profile,
          matchedAt: DateTime.now(),
          lastMessage: 'You matched with ${profile.name}. Say hi! 👋',
        ),
      );
    matches.value = updated;
  }

  void markOpened(Match match) {
    if (!match.isNew) return;
    match.isNew = false;
    // Reassign to trigger listeners.
    matches.value = List<Match>.from(matches.value);
  }
}
