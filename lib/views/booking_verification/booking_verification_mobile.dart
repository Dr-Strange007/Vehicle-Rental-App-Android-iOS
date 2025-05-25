import 'package:pin_code_fields/pin_code_fields.dart';
import '/backend/utils/custom_loading_api.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/text_labels/title_subtitle_widget.dart';
import '../../controller/booking_verification/booking_verification_controller.dart';
import '../../language/language_controller.dart';
import '../../widgets/app_logo/app_logo_widget.dart';

class BookingVerificationMobile extends StatelessWidget {
  BookingVerificationMobile({
    super.key,
    required this.controller,
  });

  final BookingVerificationController controller;
  final Color buttonColor = Get.isDarkMode
      ? CustomColor.primaryDarkColor
      : CustomColor.primaryLightColor;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const PrimaryAppBar(Strings.bookingVerification),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: crossCenter,
          children: [
            verticalSpace(Dimensions.heightSize * 5),
            _appLogoWidget(context),
            verticalSpace(Dimensions.heightSize * 2),
            _otpWidget(context),
          ],
        ),
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
              title: Strings.submit,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.bookingVerifyProcess();
                }
              },
              borderColor: buttonColor,
              buttonColor: buttonColor,
            )),
    );
  }

  _appLogoWidget(BuildContext context) {
    return LogoWidget(
      scale: 1.5,
    );
  }

  _otpWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 4),
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Column(
        children: [
          TitleSubTitleWidget(
            title: Strings.pleaseEnterTheCode,
            subTitle: Strings.enterTheOtpVerification,
            isCenterText: true,
          ),
          _otpInputWidget(context),
          _timeWidget(context),
          _buttonWidget(context),
          _resendButton(context),
        ],
      ),
    );
  }

  _timeWidget(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          top: Dimensions.paddingSize,
          bottom: Dimensions.paddingSize,
        ),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            Icon(
              Icons.watch_later_outlined,
              color: Theme.of(context).primaryColor,
            ),
            horizontalSpace(Dimensions.widthSize * 0.5),
            TitleHeading4Widget(
              text: controller.secondsRemaining.value >= 0 &&
                      controller.secondsRemaining.value <= 9
                  ? '00:0${controller.secondsRemaining.value}'
                  : '00:${controller.secondsRemaining.value}',
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }

  _resendButton(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.enableResend.value,
        child: InkWell(
          onTap: () {
            controller.resendCode();
          },
          child: const TitleHeading4Widget(text: Strings.resendCode),
        ),
      ),
    );
  }

  _otpInputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.radius),
        ),
      ),
      child: PinCodeTextField(
        appContext: context,
        backgroundColor: Colors.transparent,
        textStyle: Get.isDarkMode
            ? CustomStyle.darkHeading2TextStyle
            : CustomStyle.lightHeading2TextStyle,
        enableActiveFill: true,
        pastedTextStyle: TextStyle(
          color: Colors.orange.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        validator: (v) {
          if (v!.length < 5) {
            return Get.find<LanguageController>()
                .getTranslation(Strings.pleaseFillOutTheField);
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldHeight: 48,
          fieldWidth: 50,
          inactiveColor: Colors.transparent,
          activeColor: Colors.transparent,
          selectedColor: Colors.transparent,
          inactiveFillColor: CustomColor.primaryBGLightColor,
          activeFillColor: CustomColor.primaryBGLightColor,
          selectedFillColor: CustomColor.primaryBGLightColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
        ),
        cursorColor: Theme.of(context).primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        errorAnimationController: controller.errorController,
        controller: controller.pinCodeController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {},
        onChanged: (value) {
          controller.changeCurrentText(value);
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
