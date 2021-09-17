import 'package:flutter/material.dart';
import 'package:my_resto/common/navigation.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/provider/database_provider.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:my_resto/utils/result_state.dart';
import 'package:my_resto/widgets/favorite_item.dart';
import 'package:provider/provider.dart';

import 'favorite_page.dart';

class HomeFavorite extends StatelessWidget {
  Widget _buildFavoriteRestoItem(BuildContext context, Restaurant resto) {
    return FavoriteItem(context: context, resto: resto);
  }

  @override
  Widget build(BuildContext context) {
    final baseSize = MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          // margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Favorites',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold, color: primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigation.intent(FavoritePage.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'View all',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 140,
          child: Consumer<DatabaseProvider>(
            builder: (context, snapshot, child) {
              ResultState state = snapshot.state;
              if (state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else {
                List<Restaurant>? restaurants = snapshot.restaurants;
                if (restaurants.isNotEmpty) {
                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return _buildFavoriteRestoItem(context, restaurants[index]);
                    },
                    scrollDirection: Axis.horizontal,
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(bottom: 50),
                    height: baseSize / 2,
                    width: baseSize / 2,
                    alignment: Alignment.center,
                    child: Text(
                      'You haven\'t added favorites yet',
                      style: TextStyle(color: primaryColor),
                    ),
                  );
                }
              }
            },
          ),
        )
      ],
    );
  }
}
