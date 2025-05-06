import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant_list.dart';
import 'package:restaurant_app/services/restaurant_services.dart';

enum ResultState { loading, noData, hasData, error }

class ListRestaurantProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;

  ListRestaurantProvider({required this.restaurantServices}) {
    _fetchAllRestaurant();
  }

  late ListRestaurant _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurant get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await restaurantServices.getListRestaurant();
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
