import 'package:dotted_line/dotted_line.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class HistoryCardWidget extends StatelessWidget {
  HistoryCardWidget(
      {super.key,
      required this.pickUpPoint,
      required this.destination,
      required this.pickupTime,
      required this.destinationTime,
      required this.status,
      required this.amount,
      required this.carName});
  final textColor = Get.isDarkMode
      ? CustomColor.secondaryDarkTextColor
      : CustomColor.secondaryLightTextColor;
  final String pickUpPoint,
      destination,
      pickupTime,
      destinationTime,
      status,
      amount,
      carName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.heightSize * 0.5,
          horizontal: Dimensions.widthSize * 0.5),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.widthSize * 1.7,
        vertical: Dimensions.heightSize,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radius),
          ),
          color:
              Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          _textWidget(context),
          verticalSpace(Dimensions.heightSize * 0.75),
          Row(
            children: [
              _rowTextWidget(context, Symbols.my_location, pickUpPoint),
              horizontalSpace(Dimensions.widthSize),
              _rowTextWidget(context, Symbols.location_on, destination),
            ],
          ),
          verticalSpace(Dimensions.heightSize * 0.3),
          Row(
            children: [
              _rowTextWidget(context, Symbols.event, pickupTime),
              horizontalSpace(Dimensions.widthSize),
              _rowTextWidget(context, Symbols.schedule, destinationTime),
            ],
          ),
          verticalSpace(Dimensions.heightSize),
          const DottedLine(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            lineLength: double.infinity,
            lineThickness: 1.0,
            dashLength: 4.0,
            dashRadius: 0.0,
            dashGapLength: 4.0,
            dashGapColor: Colors.transparent,
            dashColor: CustomColor.deactivateColor,
            dashGapRadius: 0.0,
          ),
          verticalSpace(Dimensions.heightSize),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius),
                  ),
                ),
                child: TitleHeading5Widget(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widthSize * 1.2,
                    vertical: Dimensions.heightSize * 0.33,
                  ),
                  text: status,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.headingTextSize6,
                  color: Get.isDarkMode
                      ? CustomColor.blackColor
                      : CustomColor.whiteColor,
                ),
              ),
              TitleHeading3Widget(
                text: amount,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
                color: Theme.of(context).primaryColor,
              )
            ],
          )
        ],
      ),
    );
  }

  _textWidget(BuildContext context) {
    return TitleHeading3Widget(text: carName);
  }

  _rowTextWidget(BuildContext context, IconData? icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: textColor,
          size: 16.sp,
        ),
        horizontalSpace(Dimensions.widthSize * 0.5),
        TitleHeading5Widget(
          text: text,
          fontWeight: FontWeight.w600,
          color: textColor,
        )
      ],
    );
  }
}
