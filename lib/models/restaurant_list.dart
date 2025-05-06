class ListRestaurant {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  ListRestaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });
  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(json["restaurants"]
            .map((x) => Restaurant.fromJson(x))
            .where((restaurant) =>
                restaurant.name != null &&
                restaurant.description != null &&
                restaurant.pictureId != null &&
                restaurant.city != null &&
                restaurant.rating != null)),
      );
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );
}
