/// A person shown in the discovery deck.
class Profile {
  final String id;
  final String name;
  final int age;
  final String job;
  final String distance; // e.g. "3 km away"
  final String bio;
  final List<String> photos;
  final List<String> interests;

  /// Whether this person has already liked the current user. Used to decide
  /// whether swiping right results in an instant match.
  final bool likesYou;

  const Profile({
    this.id,
    this.name,
    this.age,
    this.job,
    this.distance,
    this.bio,
    this.photos,
    this.interests,
    this.likesYou = false,
  });

  String get heroPhoto => (photos != null && photos.isNotEmpty) ? photos.first : null;
}
