import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late List<dynamic> categories;
  late Map<dynamic, dynamic> menus = {};
  late List<dynamic> review;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.categories = const [],
    this.menus = const {},
    this.review = const [],
  });

  Restaurant.fromJson(Map<String, dynamic> resto) {
    id = resto['id'];
    name = resto['name'];
    description = resto['description'];
    pictureId = resto['pictureId'];
    city = resto['city'];
    rating = resto['rating'];
    categories = resto['categories'] ?? [];
    menus = resto['menus'] ?? {};
    review = resto['customerReviews'] ?? [];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "categories": categories,
        "menus": menus,
        "review": review
      };
}

List<Restaurant> parseRestaurants(String? json) {
  var mapJson = jsonDecode(json!);
  if (mapJson != null) {
    final List parsed = mapJson['restaurants'] ?? [];
    return parsed.map((jsonResto) => Restaurant.fromJson(jsonResto)).toList();
  } else {
    return [];
  }
}

class RestaurantsResult {
  bool error;
  String message;
  num count;
  List<Restaurant> restaurants;

  RestaurantsResult({
    required this.error,
    this.message = '',
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) => RestaurantsResult(
        error: json['error'],
        count: json['count'],
        message: json['message'],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": restaurants,
      };
}

class RestaurantResult {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantResult({required this.error, this.message = '', required this.restaurant});

  factory RestaurantResult.fromJson(Map<String, dynamic> json) => RestaurantResult(
        error: json['error'],
        message: json['message'],
        restaurant: Restaurant.fromJson(json['restaurant']),
      );
}

class FindRestaurantResult {
  bool error;
  num founded;
  List<Restaurant> restaurants;

  FindRestaurantResult({required this.error, required this.founded, required this.restaurants});

  factory FindRestaurantResult.fromJson(Map<String, dynamic> json) => FindRestaurantResult(
        error: json['error'],
        founded: json['founded'],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class AddReviewResult {
  bool error;
  String message;
  List<dynamic> customerReview;

  AddReviewResult({required this.error, this.message = '', required this.customerReview});

  factory AddReviewResult.fromJson(Map<String, dynamic> json) => AddReviewResult(
        error: json['error'],
        message: json['message'],
        customerReview: json['customerReviews'],
      );
}
