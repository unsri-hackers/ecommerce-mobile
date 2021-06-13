import 'package:deuvox/app/utils/color_utils.dart';
import 'package:deuvox/app/utils/font_utils.dart';
import 'package:flutter/material.dart';

class Utils {
  static Widget circularImage(String path) {
    return ClipOval(
      child: Container(
        child: Image.asset(path),
      ),
    );
  }
}

class OnGoingOrderListItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final String date;

  OnGoingOrderListItem({
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: isFirst ? 24 : 10, right: isLast ? 24 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  color: ColorHex(ColorUtils.thumbnail_blue_1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                        ),
                        color: ColorHex(ColorUtils.thumbnail_blue_2),
                      ),
                    ),
                    Container(
                      height: 38,
                      width: 38,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                        ),
                        color: ColorHex(ColorUtils.thumbnail_blue_3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontUtils.louisGeorgeCafe,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 3),
          Text(
            date,
            style: TextStyle(
              fontFamily: FontUtils.louisGeorgeCafe,
              fontSize: 11,
              color: ColorHex(ColorUtils.gray_text),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCategoryListItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final String imagePath;

  ProductCategoryListItem({
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      margin: EdgeInsets.only(left: isFirst ? 24 : 10, right: isLast ? 24 : 0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(imagePath),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontUtils.louisGeorgeCafe,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class YourProductListItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final String price;
  final String imagePath;
  final String rating;

  YourProductListItem({
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 120,
      margin: EdgeInsets.only(left: isFirst ? 24 : 10, right: isLast ? 24 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 25,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.black54,
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 6, top: 3),
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3, top: 3),
                    child: Text(
                      rating,
                      style: TextStyle(
                        fontFamily: FontUtils.louisGeorgeCafe,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontUtils.louisGeorgeCafe,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 3),
          Text(
            price,
            style: TextStyle(
              fontFamily: FontUtils.louisGeorgeCafe,
              fontSize: 11,
              color: ColorHex(ColorUtils.gray_text),
            ),
          ),
        ],
      ),
    );
  }
}
