import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurant_detail.dart'
    as detail_restaurant;
import 'package:restaurant_app/providers/restaurant_search.dart';
import 'package:restaurant_app/services/restaurant_services.dart';
import 'package:restaurant_app/views/theme/theme.dart';
import 'package:restaurant_app/views/detail_restaurant.dart';
import 'package:restaurant_app/views/widgets/restaurant_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void searchByName(String query) {
    Provider.of<SearchRestaurantProvider>(context, listen: false)
        .searchRestaurant(query);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: CustomScrollView(
          slivers: [
            _searchBar(),
            _restaurantCard(),
          ],
        ),
      ),
    );
  }

  Consumer<SearchRestaurantProvider> _restaurantCard() {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return SliverList.builder(
            itemCount: state.result.restaurants.length,
            itemBuilder: ((context, index) {
              final restaurant = state.result.restaurants[index];
              return RestaurantCard(
                pictureId: restaurant.pictureId,
                name: restaurant.name,
                city: restaurant.city,
                rating: restaurant.rating.toString(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider<
                          detail_restaurant.DetailRestaurantProvider>(
                        create: (_) =>
                            detail_restaurant.DetailRestaurantProvider(
                          restaurantServices: RestaurantServices(),
                          id: restaurant.id,
                        ),
                        child: const RestaurantDetail(),
                      ),
                    ),
                  );
                },
              );
            }),
          );
        } else if (state.state == ResultState.noData) {
          return SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state.state == ResultState.empty) {
          return SliverFillRemaining(
            child: Column(
              children: [
                const Spacer(),
                Icon(
                  Icons.screen_search_desktop_outlined,
                  color: Colors.grey.shade100,
                  size: 100.0,
                ),
                Align(
                  child: Text(
                    'Cari tempat berdasarkan nama, kategori, dan menu.',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        } else {
          return SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        }
      },
    );
  }

  SliverAppBar _searchBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      surfaceTintColor: Colors.transparent,
      pinned: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: TextField(
          onChanged: searchByName,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Cari tempat nongki!',
            prefixIcon: Icon(Icons.search),
            prefixIconColor: secondaryColor,
          ),
          cursorColor: secondaryColor,
        ),
      ),
    );
  }
}
