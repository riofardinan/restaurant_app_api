import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/restaurant_detail.dart';
import 'package:restaurant_app/models/restaurant_list.dart';
import 'package:restaurant_app/models/restaurant_search.dart';

class RestaurantServices {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestaurant> getListRestaurant() async {
    final response = await http.get(Uri.parse('${_baseUrl}list'));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future getDetailRestaurant(id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future searchRestaurant(query) async {
    final response = await http.get(Uri.parse('${_baseUrl}search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  String buildImageUrl(String pictureId) {
    return '$_baseUrl/images/medium/$pictureId';
  }
}
