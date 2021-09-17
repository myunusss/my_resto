import 'package:flutter/material.dart';
import 'package:my_resto/styles/styles.dart';

class MenuItem extends StatelessWidget {
  final String? name;
  final String? image;
  final String? price;

  const MenuItem({
    Key? key,
    this.name,
    this.image,
    this.price = 'Rp. 18.000',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: secondaryColor,
          content: Text(
            '$name - $price',
          ),
          duration: Duration(milliseconds: 1000),
        ));
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image ?? 'images/empty_image.png',
              height: 60,
              width: 80,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '-',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 5),
                Text(
                  price ?? '-',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: secondaryColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
