import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import '/utils/basic_screen_imports.dart';

import '../../language/language_controller.dart';

class CustomDropDownButton extends StatelessWidget {
  final RxString selectMethod;
  final List<String> itemsList;
  final void Function(String?)? onChanged;
  final String label;

  const CustomDropDownButton({
    required this.itemsList,
    super.key,
    required this.selectMethod,
    this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Obx(() => Column(
          crossAxisAlignment: crossStart,
          children: [
            Text(
              Get.find<LanguageController>().getTranslation(label),
              style: CustomStyle.darkHeading3TextStyle.copyWith(
                color: CustomColor.primaryLightTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(Dimensions.heightSize * 0.75),
            Container(
              height: isTablet()
                  ? Dimensions.heightSize * 6
                  : Dimensions.heightSize * 4.3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomColor.whiteColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    Get.find<LanguageController>()
                        .getTranslation(selectMethod.value),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.headingTextSize3,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode
                          ? CustomColor.primaryDarkTextColor.withOpacity(.30)
                          : CustomColor.primaryLightTextColor.withOpacity(.30),
                    ),
                  ),
                  underline: Container(),
                  isExpanded: true,
                  menuItemStyleData: MenuItemStyleData(height: 50.h),
                  iconStyleData: const IconStyleData(
                      icon: Icon(
                        Symbols.arrow_drop_down,
                      ),
                      iconDisabledColor: CustomColor.primaryLightTextColor,
                      iconEnabledColor: CustomColor.deactivateColor),
                  dropdownStyleData: DropdownStyleData(
                      maxHeight: isTablet() ? 150.h : 100.h,
                      // width: MediaQuery.sizeOf(context).width * .5,
                      // useSafeArea: true,

                      decoration: const BoxDecoration(
                        color: CustomColor.primaryLightColor,
                      )),
                  items: itemsList.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomStyle.lightHeading5TextStyle
                            .copyWith(color: CustomColor.whiteColor),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ));
  }
}
