import 'package:flutter/gestures.dart';
import '/language/language_controller.dart';

import '../../../backend/utils/custom_snackbar.dart';
import '../../../controller/auth/sign_up/sign_up_controller.dart';
import '../../../controller/basic_settings/basic_settings_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/inputs/country_picker_input_widget.dart';
import '../../../widgets/inputs/primary_input_widget.dart';
import '../../web_view/web_view_screen.dart';
import '/backend/utils/custom_loading_api.dart';
import '/widgets/app_logo/app_logo_widget.dart';

class SignUpMobileScreenLayout extends StatelessWidget {
  SignUpMobileScreenLayout({
    super.key,
    required this.controller,
  });

  final SignUpController controller;
  final Color buttonColor = Get.isDarkMode
      ? CustomColor.primaryLightColor
      : CustomColor.primaryDarkColor;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        verticalSpace(Dimensions.marginSizeVertical * 2),
        LogoWidget(
          scale: 1,
        ),
        _welcomeTextWidget(context),
        _fieldsWidget(context),
      ],
    );
  }

  _welcomeTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.7,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TitleHeading2Widget(
            text: Strings.welcomeSignUp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
            fontSize: Dimensions.headingTextSize2 * 0.9,
          ),
          verticalSpace(Dimensions.heightSize * 0.3),
          TitleHeading4Widget(
            text: Strings.welcomeSignUpMsg,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.headingTextSize5,
            color: Get.isDarkMode
                ? CustomColor.secondaryDarkTextColor
                : CustomColor.secondaryLightTextColor,
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.signUp,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (controller.agreed.value) {
                    controller.onSignUp;
                  } else {
                    CustomSnackBar.error(Strings.pleaseAgree);
                  }
                }
              },
              borderColor: buttonColor,
              buttonColor: buttonColor,
            )),
    );
  }

  _fieldsWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.6,
        padding: EdgeInsets.all(Dimensions.paddingSize),
        decoration: BoxDecoration(
          // color: Get.isDarkMode
          //     ? CustomColor.primaryBGDarkColor
          //     : CustomColor.primaryBGLightColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius * 3),
            topLeft: Radius.circular(Dimensions.radius * 3),
          ),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _inputFieldWidget(context),
            _agreedWidget(context),
            _buttonWidget(context),
            _alreadyHaveAccountWidget(context),
            verticalSpace(Dimensions.heightSize),
          ],
        ),
      ),
    );
  }

  _agreedWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.66),
      child: Row(
        children: [
          Obx(
            () => SizedBox(
              height: 24.0.h,
              width: 24.0.w,
              child: Checkbox(
                value: controller.agreed.value,
                onChanged: (value) {
                  controller.agreed.value = value!;
                },
                activeColor: Theme.of(context).primaryColor,
                checkColor: controller.agreed.value
                    ? CustomColor.primaryBGLightColor
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.2),
                ),
                side: BorderSide(
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
                      : CustomColor.primaryLightTextColor.withOpacity(0.50),
                ),
              ),
            ),
          ),
          horizontalSpace(Dimensions.widthSize * 0.4),
          RichText(
            text: TextSpan(
              text: Get.find<LanguageController>()
                  .getTranslation(Strings.pleaseAgree),
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle
                  : CustomStyle.lightHeading5TextStyle
                      .copyWith(color: CustomColor.primaryLightColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(
                    () => WebViewScreen(
                      title: Strings.privacyPolicy,
                      url: Get.find<BasicSettingsController>()
                          .privacyPolicy
                          .value,
                    ),
                  );
                },
            ),
          ),
        ],
      ),
    );
  }

  _alreadyHaveAccountWidget(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: Get.find<LanguageController>()
              .getTranslation(Strings.alreadyHaveAnAccount),
          style: Get.isDarkMode
              ? CustomStyle.darkHeading5TextStyle
              : CustomStyle.lightHeading5TextStyle,
          children: [
            TextSpan(
              text:
                  " ${Get.find<LanguageController>().getTranslation(Strings.signIn)}",
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                    )
                  : CustomStyle.lightHeading5TextStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(Routes.signInScreen);
                },
            )
          ],
        ),
      ),
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.firstNameController,
                hintText: Strings.enterName,
                label: Strings.firstName,
                // prefixIconPath: Assets.icon.user,
                textInputType: TextInputType.text,
                fillColor: CustomColor.whiteColor,
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.lastNameController,
                hintText: Strings.enterName,
                label: Strings.lastName,
                // prefixIconPath: Assets.icon.user,
                textInputType: TextInputType.text,
                fillColor: CustomColor.whiteColor,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize * 1.6),
        PrimaryInputWidget(
          controller: controller.emailAddressController,
          hintText: Strings.enterEmailAddress,
          label: Strings.emailAddress,
          // prefixIconPath: Assets.icon.clock,
          textInputType: TextInputType.emailAddress,
          fillColor: CustomColor.whiteColor,
        ),
        verticalSpace(Dimensions.heightSize * 1.6),
        ProfileCountryCodePickerWidget(
          hintText: '',
          controller: controller.countryController,
          onChanged: (value) {
            controller.countryController.text = value!.name;
            controller.selectCountryCode.value = value.toString();
            debugPrint(controller.selectCountryCode.value);
          },
          // countryCode: controller.selectCountry,
        ),
        verticalSpace(Dimensions.heightSize * 1.6),
        PrimaryInputWidget(
          controller: controller.passwordController,
          hintText: Strings.enterPassword,
          label: Strings.password,
          // prefixIconPath: Assets.icon.lock,
          fillColor: CustomColor.whiteColor,
          isPasswordField: true,
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}
