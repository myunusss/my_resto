import 'package:flutter/material.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/provider/database_provider.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:my_resto/utils/result_state.dart';
import 'package:my_resto/widgets/background_base.dart';
import 'package:my_resto/widgets/resto_item.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const routeName = '/favorite_page';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

Widget _buildRestoItem(BuildContext context, Restaurant resto) {
  return RestoItem(context: context, resto: resto);
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final baseSize = MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundBase(),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.only(bottom: 15, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'My Favorites',
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Flexible(
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
                              return _buildRestoItem(context, restaurants[index]);
                            },
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.only(bottom: 50),
                            height: baseSize / 2,
                            width: baseSize / 2,
                            alignment: Alignment.center,
                            child: Text('No restaurant available!'),
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
