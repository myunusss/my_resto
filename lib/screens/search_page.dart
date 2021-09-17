import 'package:flutter/material.dart';
import 'package:my_resto/data/api_service.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:my_resto/widgets/background_base.dart';
import 'package:my_resto/widgets/resto_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

Widget _buildRestoItem(BuildContext context, Restaurant resto) {
  return RestoItem(context: context, resto: resto);
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController queryController = TextEditingController();
  late Future<FindRestaurantResult> _restaurantsResult;

  @override
  void initState() {
    super.initState();
    _restaurantsResult = ApiService().findRestaurantOrMenu('');
  }

  @override
  Widget build(BuildContext context) {
    final baseSize = MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.9),
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
                        'Search',
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: queryController,
                        onEditingComplete: () {
                          setState(() {
                            _restaurantsResult =
                                ApiService().findRestaurantOrMenu(queryController.text);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Your favorite restaurant or menu',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(width: 1, color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: FutureBuilder(
                    future: _restaurantsResult,
                    builder: (context, AsyncSnapshot<FindRestaurantResult> snapshot) {
                      var state = snapshot.connectionState;
                      if (state != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        List<Restaurant>? restaurants = snapshot.data?.restaurants ?? [];
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
