import 'package:flutter/cupertino.dart';
import 'package:my_resto/common/navigation.dart';
import 'package:my_resto/data/api_service.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:my_resto/provider/restaurant_provider.dart';
import 'package:my_resto/screens/detail_page.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:provider/provider.dart';

class RestoItem extends StatelessWidget {
  final BuildContext context;
  final Restaurant resto;

  const RestoItem({
    Key? key,
    required this.context,
    required this.resto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RestaurantProvider restaurantProvider =
            Provider.of<RestaurantProvider>(context, listen: false);
        restaurantProvider.updateRestaurant(resto);
        Navigation.intentWithData(DetailPage.routeName, resto);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Hero(
              tag: resto.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  ApiService().loadImage(resto.pictureId, Size.small),
                  height: 77,
                  width: 100,
                  fit: BoxFit.fill,
                  loadingBuilder:
                      (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(child: CircularProgressIndicator(color: secondaryColor)),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    resto.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place_rounded,
                        size: 16,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 3),
                      Text(
                        resto.city,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate_sharp,
                        size: 16,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 3),
                      Text(
                        resto.rating.toString(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
