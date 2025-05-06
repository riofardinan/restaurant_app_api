import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant_search.dart';
import 'package:restaurant_app/services/restaurant_services.dart';

enum ResultState { loading, noData, hasData, error, empty }

class SearchRestaurantProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices = RestaurantServices();

  late SearchRestaurant _restaurantResult;
  late ResultState _state = ResultState.empty;
  String _message = '';

  String get message => _message;

  SearchRestaurant get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await restaurantServices.searchRestaurant(query);
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurants Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantList;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'No Internet Connection';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Failed to Load Data';
      }
    }
  }
}
