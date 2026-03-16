// =============================================================================
// travel_data.dart — Hard-Coded Data Source
// Flutter Lab: Multi-Screen Travel App UI
// =============================================================================
//
// ALL data in this app is hard-coded here. No API or database is used.
// Images are loaded from local assets (assets/images/) declared in pubspec.yaml.
//
// -----------------------------------------------------------------------------
// WIDGET INVENTORY (26 distinct Flutter widgets used across the project)
// -----------------------------------------------------------------------------
//
//  Layout & Structure
//  01. Scaffold          — base screen structure (every screen)
//  02. AppBar            — top bar with title + actions (BookingScreen, MyBookings)
//  03. SliverAppBar      — collapsible hero app bar (HomeScreen, DetailScreen)
//  04. CustomScrollView  — sliver-based scrollable body (HomeScreen, ExploreScreen)
//  05. SingleChildScrollView — simple scrollable body (BookingScreen, ProfileScreen)
//  06. SafeArea          — respects system insets (MainShell bottom nav)
//  07. IndexedStack      — preserves state across bottom-nav tabs (MainShell)
//  08. Stack             — layered widgets, used for image overlays (DestinationCard)
//  09. Positioned        — absolute child inside Stack (DestinationCard, BookingCard)
//
//  Lists & Grids
//  10. ListView.builder  — horizontal featured cards + vertical popular list
//  11. SliverList        — lazy list inside CustomScrollView (HomeScreen, ExploreScreen)
//  12. SliverGrid        — 2-column grid view in ExploreScreen (grid toggle)
//  13. GridView.builder  — used inside ExploreScreen grid delegate
//
//  Display
//  14. Image.asset       — local asset images (all destination images)
//  15. Hero              — shared-element transition between Home → Detail
//  16. ClipRRect         — rounded image corners (DestinationCard, BookingCard)
//  17. DecoratedBox      — gradient overlay on card images
//  18. CircleAvatar      — profile avatar (HomeScreen AppBar, ProfileScreen)
//  19. Chip              — destination tag pills (DetailScreen)
//  20. RichText          — mixed-style price text (DestinationListTile, DetailScreen)
//
//  Input & Interaction
//  21. TextField         — search bar + booking form fields
//  22. GestureDetector   — tap handling on cards, buttons, gallery thumbnails
//  23. DropdownButton    — date selector + sort-by filter (BookingScreen, ExploreScreen)
//  24. AnimatedContainer — animated category chip + favorite button state changes
//
//  Feedback
//  25. Dialog            — booking success confirmation (BookingScreen)
//  26. SnackBar          — validation error feedback (BookingScreen)
//
// -----------------------------------------------------------------------------
// CUSTOM REUSABLE WIDGET CLASSES
// -----------------------------------------------------------------------------
//  • DestinationCard      — horizontal featured card with Stack + Hero + gradient
//  • DestinationListTile  — row card for popular/explore lists
//  • BookingCard          — trip card used in MyBookingsScreen
//  • CategoryChip         — animated filter pill with gradient when selected
//  • FavoriteButton       — animated heart toggle button
//  • RatingWidget         — star + score + optional review count row
//  • CustomButton         — gradient primary button / outlined variant
//
// -----------------------------------------------------------------------------
// NAVIGATION FLOW
// -----------------------------------------------------------------------------
//  MainShell (BottomNavigationBar)
//    ├── [0] HomeScreen    → DetailScreen → BookingScreen → (success → Home)
//    ├── [1] ExploreScreen → DetailScreen → BookingScreen
//    ├── [2] FavoritesScreen → DetailScreen → BookingScreen
//    └── [3] ProfileScreen → MyBookingsScreen
//
// =============================================================================

import '../models/destination.dart';

// ---------------------------------------------------------------------------
// Asset path constants — maps each destination id to its local image file
// ---------------------------------------------------------------------------
const Map<String, String> destinationAssets = {
  '1': 'assets/images/santorini.jpg',
  '2': 'assets/images/bali.jpg',
  '3': 'assets/images/machu_picchu.jpg',
  '4': 'assets/images/maldives.jpg',
  '5': 'assets/images/kyoto.jpg',
  '6': 'assets/images/patagonia.jpg',
  '7': 'assets/images/amalfi.jpg',
  '8': 'assets/images/serengeti.jpg',
};

// ---------------------------------------------------------------------------
// Categories — used for horizontal filter chips on Home & Explore screens
// ---------------------------------------------------------------------------
const List<TravelCategory> categories = [
  TravelCategory(id: '1', name: 'All',      icon: '🌍'),
  TravelCategory(id: '2', name: 'Beach',    icon: '🏖️'),
  TravelCategory(id: '3', name: 'Mountain', icon: '🏔️'),
  TravelCategory(id: '4', name: 'City',     icon: '🏙️'),
  TravelCategory(id: '5', name: 'Forest',   icon: '🌲'),
  TravelCategory(id: '6', name: 'Desert',   icon: '🏜️'),
  TravelCategory(id: '7', name: 'Island',   icon: '🏝️'),
];

// ---------------------------------------------------------------------------
// Destinations — full hard-coded list, all images reference local assets
// ---------------------------------------------------------------------------
const List<Destination> destinations = [
  Destination(
    id: '1',
    title: 'Santorini',
    location: 'Cyclades',
    country: 'Greece',
    description:
        'Santorini is one of the most iconic destinations in the world, famous for its '
        'dramatic views, stunning sunsets, and white-washed buildings with blue domes. '
        'Perched on the edge of a volcanic caldera, this island offers a magical experience '
        'unlike any other. Explore the charming villages of Oia and Fira, relax on unique '
        'black and red sand beaches, and indulge in fresh Mediterranean cuisine with '
        'breathtaking views of the Aegean Sea.',
    price: 1299,
    rating: 4.9,
    reviews: 2847,
    imageUrl: 'assets/images/santorini.jpg',       // local asset
    gallery: [
      'assets/images/santorini.jpg',
      'assets/images/maldives.jpg',
      'assets/images/amalfi.jpg',
      'assets/images/bali.jpg',
    ],
    category: 'Island',
    tags: ['Romantic', 'Scenic', 'Luxury'],
  ),
  Destination(
    id: '2',
    title: 'Bali',
    location: 'Ubud',
    country: 'Indonesia',
    description:
        'Bali is a living postcard, an Indonesian paradise that feels like a fantasy. '
        'Impossibly green rice terraces, ancient Hindu temples, and a vibrant arts scene '
        'make this island a must-visit. From the spiritual heart of Ubud to the surf-soaked '
        'shores of Seminyak, Bali offers a rich tapestry of culture, nature, and relaxation. '
        'Discover hidden waterfalls, attend traditional ceremonies, and find your inner peace '
        'in this island of the gods.',
    price: 899,
    rating: 4.8,
    reviews: 3521,
    imageUrl: 'assets/images/bali.jpg',            // local asset
    gallery: [
      'assets/images/bali.jpg',
      'assets/images/kyoto.jpg',
      'assets/images/patagonia.jpg',
      'assets/images/serengeti.jpg',
    ],
    category: 'Island',
    tags: ['Cultural', 'Spiritual', 'Nature'],
  ),
  Destination(
    id: '3',
    title: 'Machu Picchu',
    location: 'Cusco Region',
    country: 'Peru',
    description:
        'Machu Picchu, the Lost City of the Incas, is one of the world\'s greatest '
        'archaeological sites. Perched high in the Andes Mountains at 2,430 metres above '
        'sea level, this 15th-century citadel offers a breathtaking combination of history, '
        'mystery, and natural beauty. Trek the legendary Inca Trail through cloud forests '
        'and mountain passes, or take the scenic train ride through the Sacred Valley to '
        'reach this UNESCO World Heritage Site.',
    price: 1599,
    rating: 4.9,
    reviews: 1923,
    imageUrl: 'assets/images/machu_picchu.jpg',    // local asset
    gallery: [
      'assets/images/machu_picchu.jpg',
      'assets/images/patagonia.jpg',
      'assets/images/serengeti.jpg',
      'assets/images/kyoto.jpg',
    ],
    category: 'Mountain',
    tags: ['Historical', 'Adventure', 'UNESCO'],
  ),
  Destination(
    id: '4',
    title: 'Maldives',
    location: 'North Malé Atoll',
    country: 'Maldives',
    description:
        'The Maldives is the ultimate tropical paradise — a nation of 1,200 coral islands '
        'scattered across the Indian Ocean. Crystal-clear turquoise waters, pristine '
        'white-sand beaches, and vibrant coral reefs make this destination a dream for '
        'snorkellers, divers, and luxury seekers alike. Stay in iconic overwater bungalows, '
        'watch manta rays glide beneath your glass floor, and experience sunsets that paint '
        'the sky in shades of gold and pink.',
    price: 2499,
    rating: 5.0,
    reviews: 1456,
    imageUrl: 'assets/images/maldives.jpg',        // local asset
    gallery: [
      'assets/images/maldives.jpg',
      'assets/images/santorini.jpg',
      'assets/images/amalfi.jpg',
      'assets/images/bali.jpg',
    ],
    category: 'Beach',
    tags: ['Luxury', 'Romantic', 'Diving'],
  ),
  Destination(
    id: '5',
    title: 'Kyoto',
    location: 'Kansai Region',
    country: 'Japan',
    description:
        'Kyoto, Japan\'s ancient imperial capital, is a city where tradition and modernity '
        'coexist in perfect harmony. Home to over 1,600 Buddhist temples, 400 Shinto shrines, '
        'and 17 UNESCO World Heritage Sites, Kyoto is a living museum of Japanese culture. '
        'Walk through the iconic bamboo groves of Arashiyama, witness the golden splendour '
        'of Kinkaku-ji, and experience the timeless ritual of a traditional tea ceremony in '
        'a centuries-old machiya townhouse.',
    price: 1199,
    rating: 4.8,
    reviews: 2634,
    imageUrl: 'assets/images/kyoto.jpg',           // local asset
    gallery: [
      'assets/images/kyoto.jpg',
      'assets/images/bali.jpg',
      'assets/images/machu_picchu.jpg',
      'assets/images/santorini.jpg',
    ],
    category: 'City',
    tags: ['Cultural', 'Historical', 'Temples'],
  ),
  Destination(
    id: '6',
    title: 'Patagonia',
    location: 'Torres del Paine',
    country: 'Chile',
    description:
        'Patagonia is one of the last great wilderness areas on Earth — a vast, untamed '
        'landscape of jagged peaks, ancient glaciers, and pristine lakes at the southern '
        'tip of South America. Torres del Paine National Park is the crown jewel, offering '
        'world-class trekking through some of the most dramatic scenery imaginable. Watch '
        'condors soar overhead, spot pumas in the wild, and marvel at the electric blue ice '
        'of the Grey Glacier.',
    price: 1899,
    rating: 4.7,
    reviews: 987,
    imageUrl: 'assets/images/patagonia.jpg',       // local asset
    gallery: [
      'assets/images/patagonia.jpg',
      'assets/images/machu_picchu.jpg',
      'assets/images/serengeti.jpg',
      'assets/images/maldives.jpg',
    ],
    category: 'Mountain',
    tags: ['Adventure', 'Wilderness', 'Trekking'],
  ),
  Destination(
    id: '7',
    title: 'Amalfi Coast',
    location: 'Campania',
    country: 'Italy',
    description:
        'The Amalfi Coast is a stretch of coastline on the southern edge of Italy\'s '
        'Sorrentine Peninsula that has been a UNESCO World Heritage Site since 1997. '
        'Dramatic cliffs plunge into the turquoise Tyrrhenian Sea, dotted with colourful '
        'fishing villages that cling impossibly to the rock face. Drive the winding coastal '
        'road, explore the lemon groves of Ravello, and savour fresh seafood and limoncello '
        'in the shadow of ancient cathedrals.',
    price: 1499,
    rating: 4.8,
    reviews: 2103,
    imageUrl: 'assets/images/amalfi.jpg',          // local asset
    gallery: [
      'assets/images/amalfi.jpg',
      'assets/images/santorini.jpg',
      'assets/images/maldives.jpg',
      'assets/images/kyoto.jpg',
    ],
    category: 'Beach',
    tags: ['Scenic', 'Romantic', 'Coastal'],
  ),
  Destination(
    id: '8',
    title: 'Safari Serengeti',
    location: 'Mara Region',
    country: 'Tanzania',
    description:
        'The Serengeti is Africa\'s most famous wildlife sanctuary and one of the Seven '
        'Natural Wonders of Africa. Witness the Great Migration — the largest movement of '
        'animals on Earth — as over 1.5 million wildebeest and hundreds of thousands of '
        'zebras thunder across the plains. Spot the Big Five on game drives at dawn, sleep '
        'under a canopy of stars in a luxury tented camp, and experience the raw, untamed '
        'beauty of the African savanna.',
    price: 3299,
    rating: 4.9,
    reviews: 743,
    imageUrl: 'assets/images/serengeti.jpg',       // local asset
    gallery: [
      'assets/images/serengeti.jpg',
      'assets/images/patagonia.jpg',
      'assets/images/machu_picchu.jpg',
      'assets/images/bali.jpg',
    ],
    category: 'Desert',
    tags: ['Wildlife', 'Adventure', 'Safari'],
  ),
];

// ---------------------------------------------------------------------------
// Bookings — mutable list so BookingScreen can append new bookings at runtime
// ---------------------------------------------------------------------------
List<Booking> bookings = [
  Booking(
    id: 'b1',
    destinationId: '4',
    destinationTitle: 'Maldives',
    imageUrl: 'assets/images/maldives.jpg',        // local asset
    date: 'Dec 15 – Dec 22, 2024',
    guests: 2,
    totalPrice: 4998,
    status: 'Confirmed',
  ),
  Booking(
    id: 'b2',
    destinationId: '5',
    destinationTitle: 'Kyoto',
    imageUrl: 'assets/images/kyoto.jpg',           // local asset
    date: 'Mar 10 – Mar 17, 2025',
    guests: 1,
    totalPrice: 1199,
    status: 'Upcoming',
  ),
];
