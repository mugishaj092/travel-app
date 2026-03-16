class Destination {
  final String id;
  final String title;
  final String location;
  final String country;
  final String description;
  final double price;
  final double rating;
  final int reviews;
  final String imageUrl;
  final List<String> gallery;
  final String category;
  final List<String> tags;

  const Destination({
    required this.id,
    required this.title,
    required this.location,
    required this.country,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.gallery,
    required this.category,
    required this.tags,
  });
}

class TravelCategory {
  final String id;
  final String name;
  final String icon;

  const TravelCategory({required this.id, required this.name, required this.icon});
}

class Booking {
  final String id;
  final String destinationId;
  final String destinationTitle;
  final String imageUrl;
  final String date;
  final int guests;
  final double totalPrice;
  final String status;

  const Booking({
    required this.id,
    required this.destinationId,
    required this.destinationTitle,
    required this.imageUrl,
    required this.date,
    required this.guests,
    required this.totalPrice,
    required this.status,
  });
}
