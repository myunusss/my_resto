import 'package:flutter_test/flutter_test.dart';
import 'package:my_resto/provider/restaurant_provider.dart';
import 'package:my_resto/provider/restaurants_provider.dart';

void main() {
  group('Restaurant Provider Test', () {
    test('Restaurant length should more than 0 after fetching API', () async {
      var restaurantsProvider = RestaurantsProvider();

      await restaurantsProvider.getListRestaurant();
      var restaurants = restaurantsProvider.restaurants;

      var result = restaurants!.length > 0;
      expect(result, true);
    });
    test('Restaurant should contain id, name, and pictureId after fetching API and parsing JSON',
        () async {
      var restaurantProvider = RestaurantProvider();
      var restaurantsProvider = RestaurantsProvider();
      var restaurant;

      await restaurantsProvider.getListRestaurant();
      restaurant = restaurantsProvider.restaurants![0];
      await restaurantProvider.getDetailRestaurant(restaurant);

      var result = restaurantProvider.restaurant != null &&
          restaurantProvider.restaurant!.id is String &&
          restaurantProvider.restaurant!.name is String;

      expect(result, true);
    });
  });
}
