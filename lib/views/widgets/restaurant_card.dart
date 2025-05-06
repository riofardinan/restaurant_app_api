import 'package:flutter/material.dart';
import 'package:restaurant_app/services/restaurant_services.dart';
import 'package:restaurant_app/views/theme/theme.dart';

class RestaurantCard extends StatelessWidget {
  final Function() onTap;
  final String pictureId;
  final String name;
  final String city;
  final String rating;
  const RestaurantCard({
    super.key,
    required this.pictureId,
    required this.name,
    required this.city,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Hero(
                tag: RestaurantServices().buildImageUrl(pictureId),
                child: Image.network(
                  RestaurantServices().buildImageUrl(pictureId),
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Text(
                      'Image not found',
                      style:
                          myTextTheme.labelSmall!.copyWith(color: Colors.red),
                    );
                  },
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: myTextTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(
                        city,
                        style: myTextTheme.labelMedium,
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
                        rating.toString(),
                        style: myTextTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
