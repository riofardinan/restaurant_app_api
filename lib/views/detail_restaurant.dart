import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurant_detail.dart';
import 'package:restaurant_app/services/restaurant_services.dart';
import 'package:restaurant_app/views/theme/theme.dart';
import 'package:readmore/readmore.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/detail-restaurant';

  const RestaurantDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            );
          } else if (state.state == ResultState.hasData) {
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  _imageBar(state, context),
                ];
              },
              body: _informationList(state),
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView _informationList(DetailRestaurantProvider state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Text(
                      state.result.restaurant.city,
                      style: myTextTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      state.result.restaurant.rating.toString(),
                      style: myTextTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Description',
              style: myTextTheme.headlineSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            ReadMoreText(
              state.result.restaurant.description,
              trimLines: 4,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              style: myTextTheme.bodySmall,
              moreStyle: myTextTheme.bodySmall!.copyWith(
                color: secondaryColor,
              ),
              lessStyle: myTextTheme.bodySmall!.copyWith(
                color: secondaryColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Categories',
              style: myTextTheme.headlineSmall,
            ),
            CardMenu(menu: state.result.restaurant.categories),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Foods',
              style: myTextTheme.headlineSmall,
            ),
            CardMenu(menu: state.result.restaurant.menus.foods),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Drinks',
              style: myTextTheme.headlineSmall,
            ),
            CardMenu(menu: state.result.restaurant.menus.drinks),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Reviews',
              style: myTextTheme.headlineSmall,
            ),
            _reviewList(state),
          ],
        ),
      ),
    );
  }

  SliverAppBar _imageBar(DetailRestaurantProvider state, BuildContext context) {
    return SliverAppBar(
      backgroundColor: secondaryColor,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxScroll = 200.0 - kToolbarHeight;
          double offset = constraints.maxHeight - kToolbarHeight;
          double percent = 1.0 - (offset / maxScroll);
          double titlePaddingLeft =
              Tween<double>(begin: 16, end: 64).transform(percent);
          return FlexibleSpaceBar(
            background: Hero(
              tag: RestaurantServices()
                  .buildImageUrl(state.result.restaurant.pictureId),
              child: Image.network(
                RestaurantServices()
                    .buildImageUrl(state.result.restaurant.pictureId),
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              state.result.restaurant.name,
              style: myTextTheme.headlineSmall!.copyWith(
                color: primaryColor,
              ),
            ),
            titlePadding: EdgeInsets.only(
              bottom: 16,
              left: titlePaddingLeft,
            ),
          );
        },
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: primaryColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  ListView _reviewList(DetailRestaurantProvider state) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.result.restaurant.customerReviews.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: secondaryColor,
                width: 1.0,
              ),
            ),
            borderOnForeground: true,
            elevation: 0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.result.restaurant.customerReviews[index].name,
                        style: myTextTheme.titleLarge,
                      ),
                      Text(
                        state.result.restaurant.customerReviews[index].date,
                        style: myTextTheme.labelSmall,
                      ),
                    ],
                  ),
                  Text(
                    state.result.restaurant.customerReviews[index].review,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({
    super.key,
    required this.menu,
  });

  final List<dynamic> menu;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return Card(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                menu[index].name,
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
