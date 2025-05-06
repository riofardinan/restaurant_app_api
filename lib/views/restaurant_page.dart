import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurant_detail.dart'
    as detail_restaurant;
import 'package:restaurant_app/providers/restaurant_list.dart';
import 'package:restaurant_app/services/restaurant_services.dart';
import 'package:restaurant_app/views/theme/theme.dart';
import 'package:restaurant_app/views/detail_restaurant.dart';
import 'package:restaurant_app/views/widgets/restaurant_card.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: CustomScrollView(
          slivers: [
            _introductionText(),
            _restaurantCard(),
          ],
        ),
      ),
    );
  }

  Consumer<ListRestaurantProvider> _restaurantCard() {
    return Consumer<ListRestaurantProvider>(
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
        } else {
          return const SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(''),
              ),
            ),
          );
        }
      },
    );
  }

  SliverPadding _introductionText() {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 12.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Temukan berbagai tempat nongkrong menarik!',
          style: myTextTheme.titleLarge,
        ),
      ),
    );
  }
}
