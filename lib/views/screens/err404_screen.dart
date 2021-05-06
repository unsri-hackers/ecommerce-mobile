import 'package:easy_localization/easy_localization.dart';
import '../../app/utils/assets_utils.dart';
import '../../generated/lang_utils.dart';
import '../component/common_widget.dart';
import 'package:flutter/material.dart';

/// Not found Screen when Router Path is not right
class Err404Screen extends StatelessWidget {
  const Err404Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: PlaceholderWidget(
         mainAxisAlignment: MainAxisAlignment.center,
        title: LocaleKeys.error_404_title.tr(),
        subtitle: LocaleKeys.error_404_subtitle.tr(),
        imagePath: AssetsUtils.emptyStreet,
      ),
    );
  }
}
