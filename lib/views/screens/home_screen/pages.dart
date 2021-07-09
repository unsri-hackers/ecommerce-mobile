import 'package:deuvox/app/config/app_config.dart';
import 'package:deuvox/app/utils/router_utils.dart';
import 'package:deuvox/controller/bloc/home/home_bloc.dart';
import 'package:deuvox/data/domain/item_domain.dart';
import 'package:deuvox/data/model/your_product_model.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/component/common_widget.dart';
import 'package:deuvox/views/screens/home_screen/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeScreen({required this.scaffoldKey});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  ItemDomain itemDomain = ItemDomain();
  final _pageSize = AppConfig.paginationLimit;
  late PagingController<int, YourProduct>? _pagingController;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc()..add(HomeFetched());
    _pagingController =
        PagingController(firstPageKey: 0, invisibleItemsThreshold: 2);
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController?.dispose();
    _pagingController = null;
    homeBloc.close();
    super.dispose();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final data =
          await itemDomain.getYourProducts((pageKey ~/ _pageSize), _pageSize);
      final newItems = data.result;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController?.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController?.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController?.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              pinned: false,
              floating: true,
              snap: true,
              title: HomeAppBar(
                onPressAvatar: () {},
                onPressAddProduct: () {
                  Navigator.pushNamed(context, RouterUtils.uploadItemSCreen);
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: PagedSliverGrid<int, YourProduct>(
                  pagingController: _pagingController!,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  builderDelegate: PagedChildBuilderDelegate<YourProduct>(
                    newPageProgressIndicatorBuilder: (context) =>
                        ShimmerSquareLoader(height: 160, width: 140),
                    firstPageProgressIndicatorBuilder: (context) => Column(
                      children: List.generate(
                          6,
                          (index) => Row(
                                children: [
                                  Expanded(
                                      child: ShimmerSquareLoader(
                                          height: 160, width: 140)),
                                  Expanded(
                                      child: ShimmerSquareLoader(
                                          height: 160, width: 140))
                                ],
                              )).toList(),
                    ),
                    itemBuilder: (context, entry, index) => Container(
                      child: YourProductListItem(
                        title: entry.productName!,
                        imagePath: entry.photos!.length > 0
                            ? entry.photos!.first.path
                            : null,
                        price: entry.priceFormatted!,
                        rating: entry.ratingFormatted!,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget ShimmerBuilder() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                ))
              ],
            )),
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
                    ShimmerSquareLoader(
                      height: 120,
                      width: 120,
                      margin: EdgeInsets.zero,
                    ),
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
                            )),
                      ),
                      ShimmerLoader(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                            )),
                      ),
                      ShimmerLoader(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                            )),
                      ),
                    ]),
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
                    ShimmerSquareLoader(
                      height: 120,
                      width: 120,
                      margin: EdgeInsets.zero,
                    ),
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
