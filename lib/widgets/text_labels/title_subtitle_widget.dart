import '../../utils/basic_screen_imports.dart';

class TitleSubTitleWidget extends StatelessWidget {
  TitleSubTitleWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.subTitleFontSize,
    this.titleColor,
    this.subTitleColor,
    this.isCenterText = false,
  });
  final String title, subTitle;
  final double? subTitleFontSize;
  final Color? titleColor, subTitleColor;
  final bool isCenterText;
  final Color subColor = Get.isDarkMode
      ? CustomColor.secondaryDarkTextColor
      : CustomColor.secondaryLightTextColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenterText ? crossCenter : crossStart,
      mainAxisAlignment: isCenterText ? mainCenter : mainCenter,
      children: [
        TitleHeading2Widget(
          text: title,
          color: titleColor ?? CustomColor.primaryLightTextColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.headingTextSize3,
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
        Visibility(
          visible: subTitle != '',
          child: TitleHeading4Widget(
            text: subTitle,
            color: subTitleColor ?? subColor,
            fontWeight: FontWeight.w500,
            fontSize: subTitleFontSize ?? Dimensions.headingTextSize5,
            textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          ),
        ),
      ],
    );
  }
}
