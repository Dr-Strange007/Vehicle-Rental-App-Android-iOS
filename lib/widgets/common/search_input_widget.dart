import '../../custom_assets/assets.gen.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../others/custom_image_widget.dart';

class SearchInputWidget extends StatefulWidget {
  final String hintText;
  final bool readOnly;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;

  const SearchInputWidget(
      {super.key,
      required this.hintText,
      this.readOnly = false,
      this.onFieldSubmitted,
      required this.controller});

  @override
  State<SearchInputWidget> createState() => _PrimarySearchInputWidgetState();
}

//enter your mtcn number text input field
// here is search Icon and a text field inside a card
class _PrimarySearchInputWidgetState extends State<SearchInputWidget> {
  FocusNode? focusNode;
  final secondaryColor = Get.isDarkMode
      ? CustomColor.secondaryDarkColor
      : CustomColor.secondaryLightColor;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.heightSize * 4,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimensions.radius,
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
            child: CustomImageWidget(
              height: Dimensions.heightSize * 1.5,
              width: Dimensions.widthSize * 2.4,
              path: Assets.icon.search,
              color: Get.isDarkMode
                  ? focusNode!.hasFocus
                      ? CustomColor.whiteColor.withOpacity(0.65)
                      : CustomColor.whiteColor.withOpacity(0.2)
                  : focusNode!.hasFocus
                      ? CustomColor.blackColor.withOpacity(0.65)
                      : CustomColor.blackColor.withOpacity(0.2),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              cursorColor: CustomColor.primaryLightColor,
              readOnly: widget.readOnly,
              style: CustomStyle.lightHeading3TextStyle.copyWith(
                fontSize: Dimensions.headingTextSize3,
                color: CustomColor.primaryLightColor,
              ),
              onTap: () {
                setState(() {
                  focusNode!.requestFocus();
                });
              },
              onChanged: (_) {
                debugPrint("🍏🍏🍏🍏🍏 ${widget.controller.text}");
              },
              onFieldSubmitted: widget.onFieldSubmitted,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: Get.find<LanguageController>().isLoading
                    ? " "
                    : Get.find<LanguageController>()
                        .getTranslation(widget.hintText),
                hintStyle: Get.isDarkMode
                    ? CustomStyle.darkHeading3TextStyle.copyWith(
                        color:
                            CustomColor.primaryDarkTextColor.withOpacity(0.3),
                        fontWeight: FontWeight.normal,
                        fontSize: Dimensions.heightSize * 1.33,
                      )
                    : CustomStyle.lightHeading3TextStyle.copyWith(
                        color:
                            CustomColor.primaryLightTextColor.withOpacity(0.3),
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.headingTextSize2 * 0.9,
                      ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: TextStyle(
                  color: focusNode!.hasFocus
                      ? CustomColor.primaryLightColor.withOpacity(0.2)
                      : CustomColor.primaryLightColor.withOpacity(0.1),
                  fontSize: Dimensions.headingTextSize3,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
