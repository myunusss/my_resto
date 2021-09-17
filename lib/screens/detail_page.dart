import 'package:flutter/material.dart';
import 'package:my_resto/common/navigation.dart';
import 'package:my_resto/data/api_service.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/provider/database_provider.dart';
import 'package:my_resto/provider/restaurant_provider.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:my_resto/widgets/blocked_loading_indicator.dart';
import 'package:my_resto/widgets/menu_item.dart';
import 'package:my_resto/widgets/modal_container.dart';
import 'package:my_resto/widgets/rounded_button.dart';
import 'package:my_resto/widgets/simple_dialog.dart';
import 'package:my_resto/widgets/text_form_boxed.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Restaurant restaurant;
  static const routeName = '/detail_page';

  const DetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool showDescription = false;
  bool showReview = false;
  bool loading = false;
  List<Widget> menu = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _buildMenuItems(RestaurantProvider restaurantProvider) {
    List<Widget> menuItems = [];
    if (restaurantProvider.restaurant != null) {
      Restaurant resto = restaurantProvider.restaurant!;

      if (resto.menus.isNotEmpty) {
        List<dynamic> foods = resto.menus['foods'];
        List<dynamic> drinks = resto.menus['drinks'];

        if (foods.isNotEmpty) {
          menuItems.add(Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Foods',
                style: myTextTheme.subtitle1,
              ),
              SizedBox(height: 10),
            ],
          ));

          for (var item in foods) {
            menuItems.add(MenuItem(
              name: item['name'],
            ));
          }
        }

        if (drinks.isNotEmpty) {
          menuItems.add(Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Drinks',
                style: myTextTheme.subtitle1,
              ),
              SizedBox(height: 10),
            ],
          ));

          for (var item in drinks) {
            menuItems.add(MenuItem(
              name: item['name'],
            ));
          }
        }
      } else {
        menuItems.add(Column(
          children: [
            SizedBox(height: 10),
            Text(
              'No available menus',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 10),
          ],
        ));
      }

      setState(() {
        menu = menuItems;
      });
    }
  }

  void openModalForm() {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Color.fromRGBO(0, 0, 0, 0.3),
      builder: (context) {
        return ModalContainer(
          title: 'Add new review',
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormBoxed(
                  title: 'Name',
                  isShowTitle: false,
                  maxLines: 1,
                  inputController: nameController,
                  hintText: 'Input your name',
                  onChanged: (data) {},
                  validator: (value) {},
                ),
                SizedBox(height: 10),
                TextFormBoxed(
                  title: 'Review',
                  isShowTitle: false,
                  maxLines: 4,
                  inputController: reviewController,
                  hintText: 'review',
                  onChanged: (data) {},
                  validator: (value) {},
                ),
                SizedBox(height: 20),
                RoundedButton(
                  label: 'Submit',
                  height: 40,
                  onClicked: () {
                    if (_formKey.currentState!.validate()) {
                      _addNewReview();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    _getDetailRestaurant();
  }

  void _getDetailRestaurant() async {
    var restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
    restaurantProvider.getDetailRestaurant(widget.restaurant).then((value) {
      setState(() {
        loading = false;
      });
      if (value == 'Error' || value == 'Empty Data') {
        showSimpleDialog(
            context: context, content: 'Something went wrong, please try again later!');
      } else {
        _buildMenuItems(restaurantProvider);
      }
    });
  }

  void _addNewReview() async {
    var restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
    var data = {
      "name": nameController.text,
      "review": reviewController.text,
    };

    restaurantProvider.addNewReview(widget.restaurant, data).then((value) {
      if (!value.error) {
        Navigation.back();
        setState(() {
          loading = true;
        });
        _getDetailRestaurant();
      } else {
        showSimpleDialog(context: context, content: value.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Consumer<RestaurantProvider>(
            builder: (context, snapshot, child) {
              if (snapshot.restaurant != null) {
                return NestedScrollView(
                  headerSliverBuilder: (context, isScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight: 220,
                        actions: [
                          Consumer<DatabaseProvider>(builder: (context, provider, child) {
                            return FutureBuilder(
                              future: provider.isFavorite(widget.restaurant.id),
                              builder: (context, snapshot) {
                                var isFavorite = snapshot.data ?? false;
                                return InkWell(
                                  onTap: () {
                                    isFavorite == true
                                        ? provider.removeFavorite(widget.restaurant.id)
                                        : provider.addFavorite(widget.restaurant);
                                  },
                                  child: Container(
                                    width: 60,
                                    padding: EdgeInsets.all(10),
                                    child: isFavorite == true
                                        ? Icon(Icons.favorite_sharp)
                                        : Icon(Icons.favorite_border_outlined),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                        leading: InkWell(
                          onTap: () {
                            Navigation.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Icon(Icons.arrow_back_sharp),
                          ),
                        ),
                        iconTheme: IconThemeData(
                          color: Colors.white,
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Theme.of(context).accentColor.withOpacity(0.5),
                                  Theme.of(context).accentColor.withOpacity(0.4),
                                  Theme.of(context).accentColor.withOpacity(0.3),
                                  Theme.of(context).accentColor.withOpacity(0.2),
                                  Theme.of(context).accentColor.withOpacity(0.1),
                                  Colors.white.withOpacity(0.02),
                                ],
                              ),
                            ),
                            child: Text(
                              snapshot.restaurant!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          background: Hero(
                            tag: widget.restaurant.pictureId,
                            child: Image.network(
                              ApiService().loadImage(widget.restaurant.pictureId, Size.medium),
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(color: Colors.white),
                                );
                              },
                            ),
                          ),
                          titlePadding: const EdgeInsets.only(left: 0, bottom: 0),
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rating',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rate_sharp,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    snapshot.restaurant!.rating.toString(),
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        showReview = !showReview;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          showReview
                                              ? Icons.arrow_drop_up_outlined
                                              : Icons.arrow_drop_down_outlined,
                                          color: secondaryColor,
                                        ),
                                        Text(
                                          '${snapshot.restaurant!.review.length} review',
                                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                              decoration: TextDecoration.underline,
                                              decorationColor: Colors.blue),
                                        )
                                      ],
                                    ),
                                  ),
                                  showReview
                                      ? InkWell(
                                          onTap: () {
                                            openModalForm();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.add_circle_outline,
                                                  color: secondaryColor,
                                                  size: 20,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    'Review',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: Colors.blue,
                                                        ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          showReview
                              ? SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.restaurant!.review.length,
                                    itemBuilder: (BuildContext context, int index) => Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.restaurant!.review[index]['date'],
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: 55,
                                            child: Text(
                                              snapshot.restaurant!.review[index]['review'],
                                              style: Theme.of(context).textTheme.subtitle2,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              snapshot.restaurant!.review[index]['name'],
                                              style: Theme.of(context).textTheme.caption,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 10),
                          Text(
                            'City',
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
                                snapshot.restaurant!.city,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showDescription = !showDescription;
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  child: Icon(
                                    showDescription
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    color: secondaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          showDescription
                              ? Text(
                                  snapshot.restaurant!.description,
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context).textTheme.subtitle2,
                                )
                              : SizedBox(),
                          SizedBox(height: 10),
                          Text(
                            'Menu',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: menu,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('No data available!'),
                );
              }
            },
          ),
          loading ? BlockedLoadingIndicator() : SizedBox(),
        ],
      ),
    );
  }
}
