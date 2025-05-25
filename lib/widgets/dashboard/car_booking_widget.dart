import 'package:material_symbols_icons/symbols.dart';
import '/language/language_controller.dart';

import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';

// ignore: must_be_immutable
class CarBookingWidget extends StatelessWidget {
  CarBookingWidget(
      {super.key,
      required this.experience,
      required this.carName,
      required this.carNumber,
      required this.carSeat,
      required this.carFees,
      required this.imagePath,
      this.onTap});

  final containerColor =
      Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor;
  final String experience;
  final String carName;
  final String carNumber;
  final String carSeat;
  final String carFees;
  final String imagePath;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.22,
      decoration: BoxDecoration(color: containerColor),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                height: double.infinity,
                width: 4,
                color: Theme.of(context).primaryColor,
              ),
              Column(
                crossAxisAlignment: crossStart,
                children: [
                  verticalSpace(Dimensions.heightSize),
                  _experienceWidget(context),
                  verticalSpace(Dimensions.heightSize * 0.6),
                  Row(
                    children: [
                      horizontalSpace(Dimensions.widthSize * 0.7),
                      _textWidget(context)
                    ],
                  ),
                  _detailsWidget(context),
                  verticalSpace(Dimensions.heightSize),
                  _buttonWidget(context),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.only(top: Dimensions.heightSize * 1.5),
            width: MediaQuery.sizeOf(context).width * 0.33,
            height: MediaQuery.sizeOf(context).height * 0.15,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imagePath), fit: BoxFit.contain)),
          ),
        ],
      ),
    );
  }

  _textWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.3,
      child: TitleHeading4Widget(
        text: carName,
        textOverflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  _experienceWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(Dimensions.radius * 1.5),
          topRight: Radius.circular(Dimensions.radius * 1.5),
        ),
      ),
      child: TitleHeading5Widget(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.widthSize,
          vertical: Dimensions.heightSize * 0.48,
        ),
        text:
            "$experience ${Get.find<LanguageController>().getTranslation(Strings.yearsExperience)}",
        fontWeight: FontWeight.w600,
        fontSize: Dimensions.headingTextSize6,
        color: CustomColor.whiteColor,
      ),
    );
  }

  _detailsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        _carFeatureTextWidget(context, carNumber),
        _carFeatureTextWidget(context,
            "${Get.find<LanguageController>().getTranslation(Strings.totalSeat)} $carSeat"),
        _carFeatureTextWidget(context,
            "${Get.find<LanguageController>().getTranslation(Strings.perKm)} $carFees"),
      ],
    );
  }

  _carFeatureTextWidget(BuildContext context, String text) {
    return Row(
      children: [
        horizontalSpace(Dimensions.widthSize * 1.5),
        Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get.isDarkMode
                ? CustomColor.secondaryDarkTextColor
                : CustomColor.secondaryLightTextColor,
          ),
        ),
        horizontalSpace(Dimensions.widthSize * 0.7),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.3,
          child: TitleHeading5Widget(
            text: text,
            textOverflow: TextOverflow.ellipsis,
            fontSize: Dimensions.headingTextSize6,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode
                ? CustomColor.secondaryDarkTextColor
                : CustomColor.secondaryLightTextColor,
          ),
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radius * 0.5),
          ),
        ),
        margin: EdgeInsets.only(left: Dimensions.widthSize * 2.2),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.widthSize * 0.8,
            vertical: Dimensions.heightSize * 0.416),
        child: Row(
          children: [
            TitleHeading5Widget(
              text: Strings.bookNow,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize6,
              color: Get.isDarkMode
                  ? CustomColor.blackColor
                  : CustomColor.whiteColor,
            ),
            horizontalSpace(Dimensions.widthSize * 0.5),
            Icon(
              Symbols.expand_circle_right_rounded,
              color: Get.isDarkMode
                  ? CustomColor.blackColor
                  : CustomColor.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
