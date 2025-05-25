import '/backend/utils/custom_loading_api.dart';
import '/controller/basic_settings/basic_settings_controller.dart';

import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/app_logo/app_logo_widget.dart';
import '../../widgets/text_labels/title_subtitle_widget.dart';

class OnboardMobileScreenLayout extends StatelessWidget {
  OnboardMobileScreenLayout({
    super.key,
  });

  final formKey = GlobalKey<FormState>();
  final Color buttonColor = Get.isDarkMode
      ? CustomColor.primaryLightColor
      : CustomColor.primaryDarkColor;
  final controller = Get.put(BasicSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(controller.onboardImage.value),
          fit: BoxFit.cover,
        ),
      ),
      child: _titleAndButtonWidget(context),
    );
  }

  _titleAndButtonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
      child: Column(
        children: [
          verticalSpace(Dimensions.heightSize * 5),
          LogoWidget(
            scale: 1,
          ),
          const Spacer(),
          Column(
            children: [
              TitleSubTitleWidget(
                title: controller.onBoardTitle.value,
                subTitle: controller.onBoardSubTitle.value,
                isCenterText: true,
                subTitleFontSize: Dimensions.headingTextSize5,
              ),
              verticalSpace(Dimensions.heightSize),
              _buttonWidget(context),
              verticalSpace(Dimensions.heightSize),
            ],
          ),
        ],
      ),
    );
  }

  _buttonWidget(context) {
    return PrimaryButton(
      title: Strings.getStarted,
      onPressed: () {
        Get.toNamed(Routes.signInScreen);
      },
      borderColor: buttonColor,
      buttonColor: buttonColor,
    );
  }
}
