import 'package:flutter/material.dart';
import 'package:my_resto/common/navigation.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/provider/restaurants_provider.dart';
import 'package:my_resto/screens/detail_page.dart';
import 'package:my_resto/screens/home_favorite.dart';
import 'package:my_resto/screens/search_page.dart';
import 'package:my_resto/screens/settings_page.dart';
import 'package:my_resto/utils/notification_helper.dart';
import 'package:my_resto/utils/result_state.dart';
import 'package:my_resto/widgets/background_base.dart';
import 'package:my_resto/widgets/main_menu.dart';
import 'package:my_resto/widgets/resto_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

Widget _buildRestoItem(BuildContext context, Restaurant resto) {
  return RestoItem(context: context, resto: resto);
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(DetailPage.routeName);
    _getListRestaurant();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  void _getListRestaurant() async {
    var restaurantsProvider = Provider.of<RestaurantsProvider>(context, listen: false);
    restaurantsProvider.getListRestaurant().then((value) {
      if (value == 'socketException') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Please check your internet connection!',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(milliseconds: 2000),
        ));
      }
    });
  }

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
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MyResto',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                              ),
                              // SizedBox(height: 10),
                              Text(
                                'The best restaurant for you',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          MainMenu(
                            Icons.search,
                            () {
                              Navigation.intent(SearchPage.routeName);
                            },
                            Colors.orange,
                          ),
                          MainMenu(
                            Icons.settings,
                            () {
                              Navigation.intent(SettingsPage.routeName);
                            },
                            Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                HomeFavorite(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Restaurants',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Consumer<RestaurantsProvider>(
                    builder: (context, snapshot, child) {
                      ResultState state = snapshot.state;
                      if (state == ResultState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        List<Restaurant>? restaurants = snapshot.restaurants ?? [];
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
          ],
        ),
      ),
    );
  }
}
