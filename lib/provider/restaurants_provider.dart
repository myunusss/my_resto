import 'package:flutter/foundation.dart';
import 'package:my_resto/data/api_service.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/utils/result_state.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  ResultState _state = ResultState.NoData;
  List<Restaurant>? _restaurants;
  String _message = '';

  Future<dynamic> getListRestaurant() async {
    try {
      _state = ResultState.Loading;
      RestaurantsResult result = await apiService.restaurants();
      if (result.restaurants.isNotEmpty) {
        _state = ResultState.HasData;
        _restaurants = result.restaurants;
        notifyListeners();
        return _restaurants;
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  ResultState get state => _state;
  String get message => _message;
  List<Restaurant>? get restaurants => _restaurants;
}
