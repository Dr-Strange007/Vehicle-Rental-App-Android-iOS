import '/language/language_controller.dart';

import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget(
      {super.key,
      this.onTap,
      required this.experience,
      required this.carName,
      required this.carNumber,
      required this.carSeat,
      required this.carFees,
      required this.imagePath});

  final void Function()? onTap;
  final String experience;
  final String carName;
  final String carNumber;
  final String carSeat;
  final String carFees;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Stack(
      // fit: StackFit.expand,
      // clipBehavior: Clip.hardEdge,
      children: [
        Column(
          children: [
            Container(
              height: isTablet()
                  ? MediaQuery.sizeOf(context).height * 0.125
                  : MediaQuery.sizeOf(context).height * 0.1,
            ),
            Container(
              // height: MediaQuery.sizeOf(context).height * .33,
              decoration: const BoxDecoration(color: CustomColor.whiteColor),
              child: Padding(
                padding: EdgeInsets.only(
                    // bottom: Dimensions.heightSize,
                    // top: Dimensions.heightSize * 2,
                    right: Dimensions.widthSize,
                    left: Dimensions.widthSize),
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    verticalSpace(
                      isTablet()
                          ? Dimensions.heightSize
                          : Dimensions.heightSize * 2.5,
                    ),
                    Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        _textWidget(context),
                        verticalSpace(Dimensions.heightSize * 0.1),
                        _carFeatureTextWidget(context, carNumber),
                        _carFeatureTextWidget(context,
                            "${Get.find<LanguageController>().getTranslation(Strings.totalSeat)} $carSeat"),
                        _carFeatureTextWidget(context,
                            "${Get.find<LanguageController>().getTranslation(Strings.perKm)} $carFees"),
                      ],
                    ).paddingOnly(left: Dimensions.widthSize * 0.5),
                    verticalSpace(isTablet()
                        ? Dimensions.heightSize * 0.2
                        : Dimensions.heightSize * 0.45),
                    _buttonWidget(context),
                    verticalSpace(Dimensions.heightSize),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
            top: 10,
            child: Image.network(
              imagePath,
              width: MediaQuery.sizeOf(context).width * 0.45,
              height: MediaQuery.sizeOf(context).height * 0.12,
              fit: BoxFit.values[6],
            )),
      ],
    );
  }

  _textWidget(BuildContext context) {
    return CustomTitleHeadingWidget(
      text: carName,
      style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: CustomColor.primaryLightTextColor),
    );
  }

  _carFeatureTextWidget(BuildContext context, String text) {
    return Row(
      children: [
        horizontalSpace(Dimensions.widthSize * 0.5),
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
        TitleHeading5Widget(
          text: text,
          fontSize: Dimensions.headingTextSize6,
          fontWeight: FontWeight.w500,
          textOverflow: TextOverflow.ellipsis,
          color: Get.isDarkMode
              ? CustomColor.secondaryDarkTextColor
              : CustomColor.secondaryLightTextColor,
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.5,
                color: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor)),
        child: Center(
          child: TitleHeading3Widget(
            text: Strings.bookNow,
            fontSize: Dimensions.headingTextSize6,
            fontWeight: FontWeight.w600,
            color: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
          ),
        ),
      ),
    );
  }
}
