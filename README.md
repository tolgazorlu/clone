# Spark 🔥

A beautiful **Tinder-style dating app** built with Flutter.

## Features

- **Swipe deck** — fling cards right to like, left to nope, or up to super-like, with live `LIKE` / `NOPE` / `SUPER LIKE` stamps, card rotation, and a stacked-card depth effect.
- **Match system** — when you like someone who already likes you back, an animated **"It's a Match!"** screen celebrates the connection and the match is saved.
- **Matches & messages** — a new-matches rail plus a conversation list, with unread badges in the bottom navigation.
- **Chat** — open any match and exchange messages in a clean chat UI with gradient bubbles.
- **Profile** — your own profile with stats, a Spark Gold upsell, and settings.
- **Action buttons** — rewind, nope, super-like, like, and boost controls under the deck.
- **Beautiful design** — a warm flame gradient brand system, multi-photo cards with progress bars, interest chips, and graceful offline fallbacks for photos.

## Architecture

```
lib/
├── main.dart                 # App entry + theme
├── theme/colors.dart         # Brand palette & gradients
├── models/profile.dart       # Profile model
├── data/
│   ├── profiles.dart         # Sample discovery deck
│   └── match_store.dart      # App-wide match state (ValueNotifier)
├── pages/
│   ├── root.dart             # Bottom navigation host
│   ├── discover_page.dart    # The swipe deck + match logic
│   ├── matches_page.dart     # Matches rail + conversations
│   ├── chat_page.dart        # 1:1 chat
│   ├── profile_page.dart     # Current user profile
│   └── match_overlay.dart    # "It's a Match!" celebration
└── widgets/
    ├── draggable_card.dart   # Gesture-driven swipe card
    ├── profile_card.dart     # Card face (photos, details, chips)
    ├── profile_photo.dart    # Network photo with gradient fallback
    └── action_button.dart    # Circular action buttons
```

No third-party state-management or swipe packages — everything is built on the
Flutter SDK.

## Getting started

```bash
flutter pub get
flutter run
```

Photos are loaded from the network and look great out of the box; if the device
is offline, cards fall back to a branded gradient with the person's initial.
