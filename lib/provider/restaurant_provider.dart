import 'package:flutter/foundation.dart';
import 'package:my_resto/data/api_service.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  ResultState _state = ResultState.NoData;
  Restaurant? _restaurant;
  String _message = '';

  Future<dynamic> getDetailRestaurant(Restaurant restaurant) async {
    try {
      _state = ResultState.Loading;
      RestaurantResult result = await apiService.detailRestaurant(restaurant.id);
      if (!result.error) {
        _state = ResultState.HasData;
        _restaurant = result.restaurant;
        notifyListeners();
        return _restaurant;
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error';
    }
  }

  Future<AddReviewResult> addNewReview(Restaurant restaurant, Map<String, dynamic> review) async {
    try {
      _state = ResultState.Loading;
      var body = {
        "id": restaurant.id,
        "name": review["name"],
        "review": review["review"],
      };

      AddReviewResult result = await apiService.postNewReview(body);
      return result;
    } catch (e) {
      return AddReviewResult(
        error: true,
        message: "Something wen wrong",
        customerReview: [],
      );
    }
  }

  ResultState get state => _state;
  String get message => _message;
  Restaurant? get restaurant => _restaurant;

  void updateRestaurant(Restaurant resto) {
    _restaurant = resto;
  }
}
