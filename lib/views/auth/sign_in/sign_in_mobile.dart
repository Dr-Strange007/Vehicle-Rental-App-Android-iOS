import 'dart:ui';

import 'package:flutter/gestures.dart';
import '/backend/utils/custom_loading_api.dart';
import '/language/language_controller.dart';
import '/widgets/app_logo/app_logo_widget.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../controller/auth/sign_in/sign_in_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/inputs/primary_input_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
import '../../../widgets/text_labels/title_subtitle_widget.dart';

class SignIndMobileScreenLayout extends StatelessWidget {
  SignIndMobileScreenLayout({
    super.key,
    required this.controller,
  });

  final SignInController controller;
  final formKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final Color buttonColor = Get.isDarkMode
      ? CustomColor.primaryLightColor
      : CustomColor.primaryDarkColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        verticalSpace(Dimensions.marginSizeVertical * 1.5),
        LogoWidget(
          scale: 1,
        ),
        verticalSpace(Dimensions.heightSize * 2),
        _welcomeTextWidget(context),
        _inputFieldWidget(context),
      ],
    );
  }

  _welcomeTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          const TitleHeading2Widget(
            text: Strings.signInMsg,
            fontWeight: FontWeight.w600,
          ),
          TitleHeading5Widget(
            text: Strings.welcomeToChange,
            fontWeight: FontWeight.w500,
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
          : Column(
              children: [
                PrimaryButton(
                  title: Strings.signIn,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.onSignIn;
                    }
                  },
                  borderColor: buttonColor,
                  buttonColor: buttonColor,
                ),
              ],
            )),
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        // height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.all(Dimensions.paddingSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius * 3),
            topLeft: Radius.circular(Dimensions.radius * 3),
          ),
        ),
        child: Column(
          children: [
            PrimaryInputWidget(
              controller: controller.emailAddressController,
              hintText: Strings.enterEmailAddress,
              label: Strings.emailAddress,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.emailAddress,
            ),
            verticalSpace(Dimensions.heightSize * 1.6),
            PrimaryInputWidget(
              controller: controller.passwordController,
              hintText: Strings.enterPassword,
              label: Strings.password,
              fillColor: CustomColor.whiteColor,
              isPasswordField: true,
              textInputType: TextInputType.text,
            ),
            _isRememberMeWidget(context),
            _buttonWidget(context),
            _doNotHaveAnAccount(context),
            verticalSpace(Dimensions.heightSize * 0.5),
            _guestUserWidget(context),
          ],
        ),
      ),
    );
  }

//
  _isRememberMeWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.66),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          const Row(
            children: [
              // Obx(
              //   () => SizedBox(
              //     height: 24.0.h,
              //     width: 24.0.w,
              //     child: Transform.scale(
              //       scale: 0.85,
              //       child: Checkbox(
              //         value: controller.isRemember.value,
              //         onChanged: (value) {
              //           controller.isRemember.value = value!;
              //         },
              //         activeColor: Theme.of(context).primaryColor,
              //         checkColor: controller.isRemember.value
              //             ? Theme.of(context).colorScheme.background
              //             : null,
              //         shape: RoundedRectangleBorder(
              //           borderRadius:
              //               BorderRadius.circular(Dimensions.radius * 0.2),
              //         ),
              //         side: BorderSide(
              //           color: Get.isDarkMode
              //               ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
              //               : CustomColor.primaryLightTextColor
              //                   .withOpacity(0.50),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // horizontalSpace(Dimensions.widthSize * 0.4),
              // InkWell(
              //   onTap: () {
              //     if (controller.isRemember.value) {
              //       controller.isRemember.value = false;
              //     } else {
              //       controller.isRemember.value = true;
              //     }
              //   },
              //   child: const TitleHeading5Widget(
              //     text: Strings.rememberMe,
              //     fontWeight: FontWeight.w500,
              //     color: CustomColor.secondaryLightTextColor,
              //   ),
              // ),
            ],
          ),
          InkWell(
            onTap: () {
              _showForgotPasswordDialog(context);
            },
            child: TitleHeading5Widget(
              text: Strings.forgotPassword,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _doNotHaveAnAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: Get.find<LanguageController>()
            .getTranslation(Strings.doNotHaveAnAccount),
        style: Get.isDarkMode
            ? CustomStyle.darkHeading5TextStyle.copyWith(
                color: CustomColor.secondaryDarkTextColor,
              )
            : CustomStyle.lightHeading5TextStyle.copyWith(
                color: CustomColor.secondaryLightTextColor,
              ),
        children: [
          TextSpan(
            text:
                " ${Get.find<LanguageController>().getTranslation(Strings.registerNow)}",
            style: Get.isDarkMode
                ? CustomStyle.darkHeading5TextStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                  )
                : CustomStyle.lightHeading5TextStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(Routes.signUpScreen);
              },
          )
        ],
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Dialog(
          backgroundColor: CustomColor.primaryBGLightColor,
          surfaceTintColor: CustomColor.primaryBGLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.75),
            child: Form(
              key: forgotPasswordFormKey,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisSize: mainMin,
                    children: [
                      TitleSubTitleWidget(
                        title: Strings.resetYourForgetPassword,
                        subTitle: Strings.forgetPasswordMsg,
                      ),
                      verticalSpace(Dimensions.marginSizeVertical),
                      PrimaryInputWidget(
                        controller:
                            controller.forgotPasswordEmailAddressController,
                        hintText: Strings.enterEmailAddress,
                        label: Strings.emailAddress,
                        // prefixIconPath: Assets.icon.clock,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        textInputType: TextInputType.emailAddress,
                      ),
                      verticalSpace(Dimensions.marginBetweenInputBox),
                      Obx(() => controller.isLoading
                          ? const CustomLoadingAPI()
                          : PrimaryButton(
                              title: Strings.forgotPassword,
                              onPressed: () {
                                if (forgotPasswordFormKey.currentState!
                                    .validate()) {
                                  LocalStorage.saveEmail(
                                      email: controller
                                          .forgotPasswordEmailAddressController
                                          .text);
                                  controller.onForgotPassword;
                                }
                              },
                              borderColor: buttonColor,
                              buttonColor: buttonColor,
                            )),
                    ],
                  ),
                  Positioned(
                    right: -32,
                    top: -32,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: Dimensions.radius * 1.4,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(
                          Icons.close_rounded,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  _guestUserWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.bottomNavBar);
      },
      child: TitleHeading4Widget(
        text: Strings.guestUser,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
