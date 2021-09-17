import 'package:flutter/cupertino.dart';
import 'package:my_resto/common/navigation.dart';
import 'package:my_resto/data/api_service.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:my_resto/provider/restaurant_provider.dart';
import 'package:my_resto/screens/detail_page.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:provider/provider.dart';

class FavoriteItem extends StatelessWidget {
  final BuildContext context;
  final Restaurant resto;

  const FavoriteItem({
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
        padding: EdgeInsets.all(3),
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
        child: Column(
          children: [
            Hero(
              tag: '${resto.pictureId}fav',
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
            SizedBox(height: 5),
            Text(
              resto.name,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
