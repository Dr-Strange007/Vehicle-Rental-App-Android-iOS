import 'package:country_code_picker/country_code_picker.dart';
import '/language/language_controller.dart';

import '../../../utils/basic_screen_imports.dart';

class ProfileCountryCodePickerWidget extends StatelessWidget {
  const ProfileCountryCodePickerWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.onChanged,
    // required this.countryCode
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final ValueChanged? onChanged;
  // final TextEditingController countryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Get.find<LanguageController>().getTranslation(Strings.country),
          style: CustomStyle.darkHeading3TextStyle.copyWith(
            color: CustomColor.primaryLightTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * 0.75),
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            color: CustomColor.whiteColor,
          ),
          width: double.infinity,
          child: CountryCodePicker(
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
            textStyle: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle
                : CustomStyle.lightHeading3TextStyle.copyWith(
                    color: CustomColor.primaryLightTextColor.withOpacity(0.3),
                  ),
            onChanged: (value) {
              controller.text = value.name!;
              onChanged!(value);
              // countryCode.text = value.code!;
            },
            showOnlyCountryWhenClosed: true,
            showDropDownButton: true,
            initialSelection:
                controller.text.isNotEmpty ? controller.text : "United States",
            backgroundColor: Colors.transparent,
            showCountryOnly: true,
            alignLeft: true,
            searchStyle: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle
                : CustomStyle.lightHeading4TextStyle,
            dialogTextStyle: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle
                : CustomStyle.lightHeading4TextStyle,
            onInit: (code) => {},
          ),
        ),
      ],
    );
  }
}
