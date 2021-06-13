import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:deuvox/app/utils/font_utils.dart';
import 'package:deuvox/views/component/common_icon_button.dart';
import 'package:deuvox/views/screens/home_screen/components.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                child: Utils.circularImage(AssetsUtils.userTemp),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(4),
                      border: OutlineInputBorder(),
                      hintText: 'Search for good things ...',
                      hintStyle: TextStyle(
                        fontFamily: FontUtils.louisGeorgeCafe,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              CIconButton(
                imageIcon: ImageIcon(AssetImage(AssetsUtils.present)),
                onPress: () {},
              ),
              SizedBox(width: 5),
              CIconButton(
                imageIcon: ImageIcon(AssetImage(AssetsUtils.notification)),
                onPress: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 24, top: 32),
          child: Text(
            'On Going Orders',
            style: TextStyle(
              fontFamily: FontUtils.louisGeorgeCafe,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: 120,
          margin: EdgeInsets.only(top: 12),
          // Change real data from API with ListView.builder()
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              OnGoingOrderListItem(
                isFirst: true,
                isLast: false,
                title: 'Barney Stinson',
                date: 'Due to 29 May 2021',
              ),
              OnGoingOrderListItem(
                isFirst: false,
                isLast: false,
                title: 'Ted Mosby',
                date: 'Due to 29 May 2021',
              ),
              OnGoingOrderListItem(
                isFirst: false,
                isLast: false,
                title: 'Jake Peralta',
                date: 'Due to 29 May 2021',
              ),
              OnGoingOrderListItem(
                isFirst: false,
                isLast: false,
                title: 'Barney Stinson',
                date: 'Due to 29 May 2021',
              ),
              OnGoingOrderListItem(
                isFirst: false,
                isLast: false,
                title: 'Jake Peralta',
                date: 'Due to 29 May 2021',
              ),
              OnGoingOrderListItem(
                isFirst: false,
                isLast: false,
                title: 'Ted Mosby',
                date: 'Due to 29 May 2021',
              ),
              OnGoingOrderListItem(
                isFirst: false,
                isLast: false,
                title: 'Barney Stinson',
                date: 'Due to 29 May 2021',
              ),
              OnGoingOrderListItem(
                isFirst: false,
                isLast: true,
                title: 'Jake Peralta',
                date: 'Due to 29 May 2021',
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 24, top: 16),
          child: Text(
            'Product Categories',
            style: TextStyle(
              fontFamily: FontUtils.louisGeorgeCafe,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: 130,
          margin: EdgeInsets.only(top: 12),
          // Change real data from API with ListView.builder()
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ProductCategoryListItem(
                isFirst: true,
                isLast: false,
                title: 'Music',
                imagePath: AssetsUtils.userTemp,
              ),
              ProductCategoryListItem(
                isFirst: false,
                isLast: false,
                title: 'Hoodie',
                imagePath: AssetsUtils.productTemp,
              ),
              ProductCategoryListItem(
                isFirst: false,
                isLast: true,
                title: 'Food',
                imagePath: AssetsUtils.foodTemp,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 24, top: 24),
          child: Text(
            'Your Products',
            style: TextStyle(
              fontFamily: FontUtils.louisGeorgeCafe,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: 130,
          margin: EdgeInsets.only(top: 12),
          // Change real data from API with ListView.builder()
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              YourProductListItem(
                isFirst: true,
                isLast: false,
                title: 'Fluff Top',
                price: 'Rp 439,900',
                imagePath: AssetsUtils.productTemp2,
                rating: '2.5',
              ),
              YourProductListItem(
                isFirst: false,
                isLast: false,
                title: 'Fluff Top',
                price: 'Rp 439,900',
                imagePath: AssetsUtils.productTemp2,
                rating: '2.5',
              ),
              YourProductListItem(
                isFirst: true,
                isLast: false,
                title: 'Fluff Top',
                price: 'Rp 439,900',
                imagePath: AssetsUtils.productTemp2,
                rating: '2.5',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
