import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuvox/app/config/themes.dart';
import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:deuvox/app/utils/color_utils.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/component/common_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
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
  final String title;
  final String date;

  OnGoingOrderListItem({
    required this.title,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 3),
          Text(
            date,
            style: TextStyle(
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
  final String title;
  final String imagePath;

  ProductCategoryListItem({
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 130,
          width: 130,
          foregroundDecoration: BoxDecoration(
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imagePath))),
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}

class YourProductListItem extends StatelessWidget {
  final String title;
  final String price;
  final String? imagePath;
  final String rating;

  YourProductListItem({
    required this.title,
    required this.price,
    required this.imagePath,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeColors.grey,
                  image: imagePath!=null?DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(imagePath!)): null),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.black38,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    rating,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
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
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 3),
        Text(
          price,
          style: TextStyle(
            fontSize: 12,
            color: ColorHex(ColorUtils.gray_text),
          ),
        ),
      ],
    );
  }
}

class HomeAppBar extends StatefulWidget {
  final VoidCallback? onPressAvatar;
  final VoidCallback? onPressAddProduct;
  const HomeAppBar({Key? key, this.onPressAvatar, this.onPressAddProduct}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  //  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onPressAvatar,
          child: Container(
            width: 40,
            height: 40,
            child: Utils.circularImage(AssetsUtils.userTemp),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
            child: Container(
          height: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ThemeColors.grey)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.search_for_good_things.tr(),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: ThemeColors.grey,
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ))
            ],
          ),
        )),
        SizedBox(width: 16),
        CIconButton(
          imageIcon: ImageIcon(AssetImage(AssetsUtils.present)),
          onPress: widget.onPressAddProduct??() {},
        ),
        SizedBox(width: 5),
        CIconButton(
          imageIcon: ImageIcon(AssetImage(AssetsUtils.notification)),
          onPress: () {},
        ),
      ],
    );
  }
}
