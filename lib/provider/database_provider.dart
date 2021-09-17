import 'package:flutter/foundation.dart';
import 'package:my_resto/data/db/database_helper.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  ResultState _state = ResultState.Loading;
  String _message = '';
  List<Restaurant> _restaurants = [];

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState get state => _state;
  String get message => _message;
  List<Restaurant> get restaurants => _restaurants;

  void _getFavorites() async {
    _restaurants = await databaseHelper.getFavorites();
    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getRestaurantById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
