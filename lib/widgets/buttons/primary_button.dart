import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key,
    required this.title,
    required this.onPressed,
    required this.borderColor,
    this.borderWidth = 0,
    this.height,
    required this.buttonColor,
    this.buttonTextColor = Colors.white,
    this.shape,
    this.icon,
    this.fontSize,
    this.fontWeight,
  });
  final String title;
  final VoidCallback onPressed;
  final Color borderColor;
  final double borderWidth;
  final double? height;
  final Color buttonColor;
  final Color buttonTextColor;
  final OutlinedBorder? shape;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.buttonHeight * 0.917,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape ??
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.7)),
          backgroundColor: buttonColor,
          side: BorderSide(
            width: borderWidth,
            color: borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            Text(
                Get.find<LanguageController>().isLoading ? "" : Get.find<LanguageController>().getTranslation(title),
              style: CustomStyle.darkHeading3TextStyle.copyWith(
                fontSize: fontSize ?? Dimensions.headingTextSize3,
                fontWeight: fontWeight ?? FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
