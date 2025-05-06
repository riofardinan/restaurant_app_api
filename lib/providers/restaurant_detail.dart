import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant_detail.dart';
import 'package:restaurant_app/services/restaurant_services.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class DetailRestaurantProvider extends ChangeNotifier {
  late RestaurantServices restaurantServices;
  String id;

  DetailRestaurantProvider(
      {required this.restaurantServices, required this.id}) {
    _fetchRestaurantDetail();
  }

  late DetailRestaurant _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurant get result => _restaurantDetailResult;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await restaurantServices.getDetailRestaurant(id);
      if (restaurantDetail!.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurants Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
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
