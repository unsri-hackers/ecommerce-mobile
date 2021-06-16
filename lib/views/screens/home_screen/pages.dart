import 'package:deuvox/app/config/themes.dart';
import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:deuvox/controller/bloc/home/home_bloc.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_icon_button.dart';
import 'package:deuvox/views/component/common_widget.dart';
import 'package:deuvox/views/screens/home_screen/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeScreen({required this.scaffoldKey});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc()..add(HomeFetched());
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) => homeBloc,
        child: Scaffold(
    body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {

          if (state is HomeFailure) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.failed_to_get_data.tr()),
                SizedBox(height: 15),
                CButtonFilled(
                    textLabel: LocaleKeys.retry.tr(),
                    onPressed: () {
                      homeBloc.add(HomeFetched());
                    })
              ],
            ));
          }



          if (state is HomeSuccess) {
            final ongoingOrders = state.data.ongoingOrders!
                .map((e) =>
                    OnGoingOrderListItem(title: e.title!, date: e.date!))
                .toList();

            final productCategories = state.data.productCategories!
                .map((e) => ProductCategoryListItem(
                      title: e.title!,
                      imagePath: e.photo!,
                    ))
                .toList();

            final yourProducts = state.data.yourProducts!
                .map((e) => YourProductListItem(
                      title: e.title!,
                      imagePath: e.photo!,
                      price: e.price!,
                      rating: e.rating!,
                    ))
                .toList();

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: true,
                  snap: true,
                  title: HomeAppBar(onPressAvatar: (){
                    widget.scaffoldKey.currentState!.openDrawer();
                  },),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 18, top: 20),
                        child: Text(
                          LocaleKeys.ongoing_orders.tr(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        margin: EdgeInsets.only(top: 12),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          itemExtent: 135,
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          children: ongoingOrders,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 18, top: 16),
                        child: Text(
                          LocaleKeys.product_categories.tr(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        margin: EdgeInsets.only(top: 12),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 140,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            children: productCategories),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 24),
                        child: Text(
                          LocaleKeys.your_products.tr(),
                          style: TextStyle(
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
                          itemExtent: 130,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          children: yourProducts,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }



          return ShimmerBuilder();

          }
        ),
      ),
    );
  }

  Widget ShimmerBuilder() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            snap: true,
            title: Row(
              children: [
                ShimmerCircleLoader(),
                SizedBox(width: 16),
                Expanded(
                    child: ShimmerLoader(
                      child: Container(
                        width: double.infinity,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    )
                )
              ],
            )
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 18, top: 20),
                child: Text(
                  LocaleKeys.ongoing_orders.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                height: 120,
                margin: EdgeInsets.only(top: 12),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 135,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  children: [
                    ShimmerSquareLoader(height: 120, width: 120, margin: EdgeInsets.zero,),
                    ShimmerSquareLoader(height: 120, width: 120),
                    ShimmerSquareLoader(height: 120, width: 120)
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 18, top: 16),
                child: Text(
                  LocaleKeys.product_categories.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                height: 130,
                margin: EdgeInsets.only(top: 12),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 140,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      ShimmerLoader(
                        child: Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                            )
                        ),
                      ),
                      ShimmerLoader(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                            )
                        ),
                      ),
                      ShimmerLoader(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                            )
                        ),
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 24),
                child: Text(
                  LocaleKeys.your_products.tr(),
                  style: TextStyle(
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
                  itemExtent: 130,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ShimmerSquareLoader(height: 120, width: 120, margin: EdgeInsets.zero,),
                    ShimmerSquareLoader(height: 120, width: 120),
                    ShimmerSquareLoader(height: 120, width: 120)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
