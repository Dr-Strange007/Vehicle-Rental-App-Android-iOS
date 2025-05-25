import 'package:dotted_border/dotted_border.dart';

import '../../utils/basic_screen_imports.dart';

// ignore: must_be_immutable
class BookingPreviewCardWidget extends StatelessWidget {
  BookingPreviewCardWidget(
      {super.key,
      required this.isActivate,
      required this.date,
      required this.month,
      required this.fromTime,
      required this.toTime});
  final textColor =
      Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor;
  final secondaryTextColor = Get.isDarkMode
      ? CustomColor.secondaryDarkTextColor
      : CustomColor.secondaryLightTextColor;
  RxBool isActivate = true.obs;
  final String date, month, fromTime, toTime;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }
    return DottedBorder(
      radius: Radius.circular(Dimensions.radius),
      borderType: BorderType.RRect,
      strokeWidth: 1,
      dashPattern: const [5, 5],
      color: isActivate.value
          ? Theme.of(context).primaryColor
          : CustomColor.deactivateColor,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize * 0.333),
        child: Row(
          children: [
            Container(
              height:isTablet()? 85.h:  82.h,
              width: 82.w,
              decoration: BoxDecoration(
                color: isActivate.value
                    ? Theme.of(context).primaryColor
                    : CustomColor.deactivateColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.radius),
                ),
              ),
              child: Column(
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading1Widget(
                    text: date,
                    fontSize: Dimensions.headingTextSize6 * 3.2,
                    color: textColor,
                  ),
                  TitleHeading3Widget(
                    text: month,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
            horizontalSpace(Dimensions.widthSize * 2),
            Column(
              crossAxisAlignment: crossStart,
              children: [
                TitleHeading3Widget(
                  text: Strings.pickUpDateTime,
                  fontWeight: FontWeight.w500,
                  color: secondaryTextColor,
                  fontSize: Dimensions.headingTextSize6 * 1.5,
                ),
                TitleHeading2Widget(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
                  text: fromTime,
                  color: secondaryTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
