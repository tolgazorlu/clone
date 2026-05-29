import '../models/profile.dart';

/// Sample discovery deck. Photos use Unsplash so the app looks great out of the
/// box; if the device is offline the cards fall back to a branded gradient.
const List<Profile> sampleProfiles = [
  Profile(
    id: 'p1',
    name: 'Sofia',
    age: 24,
    job: 'Photographer · Lumen Studio',
    distance: '2 km away',
    bio: 'Chasing golden hour and good coffee. Tell me your favourite trail.',
    likesYou: true,
    photos: [
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=800&q=80',
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&q=80',
    ],
    interests: ['Photography', 'Hiking', 'Coffee', 'Travel'],
  ),
  Profile(
    id: 'p2',
    name: 'Liam',
    age: 27,
    job: 'Product Designer',
    distance: '5 km away',
    bio: 'Designer by day, vinyl collector by night. Dog person. 🐕',
    likesYou: false,
    photos: [
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800&q=80',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80',
    ],
    interests: ['Design', 'Music', 'Dogs', 'Running'],
  ),
  Profile(
    id: 'p3',
    name: 'Maya',
    age: 23,
    job: 'Med Student',
    distance: '1 km away',
    bio: 'Future doctor who can\'t cook. Looking for a sushi partner in crime.',
    likesYou: true,
    photos: [
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&q=80',
      'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=800&q=80',
    ],
    interests: ['Sushi', 'Yoga', 'Books', 'Wine'],
  ),
  Profile(
    id: 'p4',
    name: 'Noah',
    age: 29,
    job: 'Chef · Osteria 21',
    distance: '8 km away',
    bio: 'I will absolutely cook for you on the third date. Maybe the first.',
    likesYou: false,
    photos: [
      'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=800&q=80',
      'https://images.unsplash.com/photo-1488161628813-04466f872be2?w=800&q=80',
    ],
    interests: ['Cooking', 'Wine', 'Cycling', 'Markets'],
  ),
  Profile(
    id: 'p5',
    name: 'Aria',
    age: 26,
    job: 'Music Producer',
    distance: '4 km away',
    bio: 'Making beats and chasing sunsets. Send me your top 3 songs.',
    likesYou: true,
    photos: [
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&q=80',
      'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=800&q=80',
    ],
    interests: ['Music', 'Festivals', 'Surfing', 'Art'],
  ),
  Profile(
    id: 'p6',
    name: 'Ethan',
    age: 31,
    job: 'Architect',
    distance: '12 km away',
    bio: 'Lover of clean lines, espresso, and weekend road trips.',
    likesYou: false,
    photos: [
      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800&q=80',
      'https://images.unsplash.com/photo-1463453091185-61582044d556?w=800&q=80',
    ],
    interests: ['Architecture', 'Travel', 'Espresso', 'Tennis'],
  ),
  Profile(
    id: 'p7',
    name: 'Isla',
    age: 25,
    job: 'Marine Biologist',
    distance: '6 km away',
    bio: 'Happiest underwater. Will talk about whales for far too long.',
    likesYou: true,
    photos: [
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800&q=80',
      'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=800&q=80',
    ],
    interests: ['Diving', 'Ocean', 'Books', 'Climbing'],
  ),
];
