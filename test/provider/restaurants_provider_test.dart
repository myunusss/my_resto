import 'package:flutter_test/flutter_test.dart';
import 'package:my_resto/provider/restaurants_provider.dart';

void main() {
  group('Restaurants Provider Test', () {
    test('Should contain restaurants when fetching restaurants API is done', () async {
      var restaurantsProvider = RestaurantsProvider();
      await restaurantsProvider.getListRestaurant();
      var result = restaurantsProvider.restaurants!.isNotEmpty;
      expect(result, true);
    });

    test('Index 0 should contain id and name after fetching API and parsing JSON done', () async {
      var restaurantsProvider = RestaurantsProvider();
      await restaurantsProvider.getListRestaurant();
      var result = restaurantsProvider.restaurants![0].id is String &&
          restaurantsProvider.restaurants![0].name is String;
      expect(result, true);
    });
  });
}
