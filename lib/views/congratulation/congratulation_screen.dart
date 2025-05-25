import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/dimensions.dart';
import '../../custom_assets/assets.gen.dart';
import '../../language/english.dart';
import '../../utils/custom_color.dart';
import '../../utils/size.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/text_labels/title_subtitle_widget.dart';

class CongratulationScreen extends StatelessWidget {
  CongratulationScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.route,
  });
  final String title, subTitle, route;
  final Color buttonColor = Get.isDarkMode
      ? CustomColor.primaryDarkColor
      : CustomColor.primaryLightColor;
  @override
  Widget build(BuildContext context) {
    Future<bool> willPop() {
      Get.offNamedUntil(route, (route) => false);
      return Future.value(true);
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        body: _bodyWidget(
          context,
        ),
      ),
    );
  }

  // body widget containing all widget elements
  _bodyWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _congratulationImageWidget(
            context,
          ),
          verticalSpace(Dimensions.heightSize * 2),
          _congratulationInfoWidget(
            context,
          ),
          verticalSpace(Dimensions.heightSize * 1.33),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: PrimaryButton(
        title: Strings.okay,
        onPressed: () {
          Get.offNamedUntil(route, (route) => false);
        },
        borderColor: buttonColor,
        buttonColor: buttonColor,
      ),
    );
  }

  _congratulationImageWidget(
    BuildContext context,
  ) {
    return Image.asset(
      Assets.clipart.confirm.path,
    );
  }

  _congratulationInfoWidget(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: Column(
        children: [
          TitleSubTitleWidget(
            title: title,
            subTitle: subTitle,
            isCenterText: true,
          ),
        ],
      ),
    );
  }
}
