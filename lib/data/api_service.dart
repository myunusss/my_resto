import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:my_resto/data/models/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _imageUrl = 'https://restaurant-api.dicoding.dev/images';

  static final String _restaurantsUrl = '$_baseUrl/list';
  static final String _restaurantDetail = '$_baseUrl/detail';
  static final String _findRestaurantOrMenu = '$_baseUrl/search';
  static final String _review = '$_baseUrl/review';

  // Image Url
  static final String _smallImage = '$_imageUrl/small';
  static final String _mediumImage = '$_imageUrl/medium';
  static final String _largeImage = '$_imageUrl/large';

  Future<RestaurantsResult> restaurants() async {
    Uri uri = Uri.parse(_restaurantsUrl);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return RestaurantsResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurants');
      }
    } on SocketException catch (_) {
      throw 'socketException';
    } catch (e) {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantResult> detailRestaurant(String id) async {
    Uri uri = Uri.parse('$_restaurantDetail/$id');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail restaurant');
      }
    } catch (e) {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<FindRestaurantResult> findRestaurantOrMenu(String query) async {
    Uri uri = Uri.parse('$_findRestaurantOrMenu?q=$query');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return FindRestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail restaurant');
      }
    } catch (e) {
      return FindRestaurantResult(error: true, founded: 0, restaurants: []);
    }
  }

  Future<AddReviewResult> postNewReview(Map<String, dynamic> body) async {
    Uri uri = Uri.parse('$_review');
    var headers = {
      "X-Auth-Token": "12345",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return AddReviewResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add review');
      }
    } catch (e) {
      return AddReviewResult(error: true, message: "", customerReview: []);
    }
  }

  String loadImage(String id, Size size) {
    if (size == Size.small) {
      return '$_smallImage/$id';
    } else if (size == Size.medium) {
      return '$_mediumImage/$id';
    } else {
      return '$_largeImage/$id';
    }
  }
}

enum Size {
  small,
  medium,
  large,
}
