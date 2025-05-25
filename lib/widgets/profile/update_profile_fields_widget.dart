import 'dart:ui';

import '/backend/utils/custom_loading_api.dart';
import '../../controller/profile/update_profile_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../common/custom_container_widget.dart';
import '../inputs/country_picker_input_widget.dart';
import '../inputs/phone_number_input_widget.dart';
import '../inputs/primary_input_widget.dart';

class UpdateProfileFieldsWidget extends StatelessWidget {
  UpdateProfileFieldsWidget({super.key, required this.controller});

  final formKey = GlobalKey<FormState>();
  final UpdateProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        // height: MediaQuery.sizeOf(context).height * 0.5,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.widthSize * 1.7,
          vertical: Dimensions.heightSize * 2,
        ),
        decoration: BoxDecoration(
          // color: CustomColor.deactivateColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius * 3),
            topLeft: Radius.circular(Dimensions.radius * 3),
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: mainMin,
            children: [
              _firstNameAndLastNameWidget(context),
              _countryWidget(context),
              _phoneNumberWidget(context),
              _addressAndCityWidget(context),
              _stateAndZipCodeWidget(context),
              _buttonWidget(context),
              verticalSpace(Dimensions.heightSize),
              _deleteButton(context),
              verticalSpace(Dimensions.heightSize * 1.33),
            ],
          ),
        ),
      ).marginZero,
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(() => controller.isUpdateLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            title: Strings.updateProfile,
            onPressed: () {
              controller.onUpdateProfile;
            },
            borderColor: Theme.of(context).primaryColor,
            buttonColor: Theme.of(context).primaryColor));
  }

  _deleteButton(BuildContext context) {
    return PrimaryButton(
      title: Strings.deleteProfile,
      onPressed: () {
        signOutDialog(context, controller);
      },
      borderColor: CustomColor.redColor,
      buttonColor: CustomColor.redColor,
    );
  }

  signOutDialog(BuildContext context, UpdateProfileController controller) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Dialog(
            backgroundColor: CustomColor.primaryBGLightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSize),
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisSize: mainMin,
                children: [
                  const TitleHeading2Widget(
                    text: Strings.deleteProfile,
                    textAlign: TextAlign.start,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  const TitleHeading4Widget(
                    text: Strings.deleteLog,
                    textAlign: TextAlign.start,
                    opacity: 0.80,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CustomContainer(
                            height: Dimensions.buttonHeight * 0.7,
                            borderRadius: Dimensions.radius * 0.8,
                            color: Get.isDarkMode
                                ? CustomColor.primaryBGLightColor
                                    .withOpacity(0.15)
                                : CustomColor.primaryBGDarkColor
                                    .withOpacity(0.15),
                            child: const TitleHeading4Widget(
                              text: Strings.cancel,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(Dimensions.widthSize),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.profileDeleteProcess();
                          },
                          child: Obx(
                            () => controller.isLoading
                                ? const CustomLoadingAPI()
                                : CustomContainer(
                                    height: Dimensions.buttonHeight * 0.7,
                                    borderRadius: Dimensions.radius * 0.8,
                                    color: Theme.of(context).primaryColor,
                                    child: const TitleHeading4Widget(
                                      text: Strings.okay,
                                      color: CustomColor.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingAll(Dimensions.paddingSize * 0.5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _firstNameAndLastNameWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.firstNameController,
            hintText: Strings.firstName,
            label: Strings.firstName,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.lastNameController,
            hintText: Strings.lastName,
            label: Strings.lastName,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.75);
  }

  _countryWidget(BuildContext context) {
    return ProfileCountryCodePickerWidget(
      controller: controller.countryController,
      hintText: '',
      onChanged: (value) {
        controller.countryController.text = value.name!;
        controller.selectCountryCode.value = value.toString();
      },
    ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.75);
  }

  _phoneNumberWidget(BuildContext context) {
    return Obx(() => PhoneNumberInputWidget(
          controller: controller.phoneNumberController,
          hintText: Strings.enterPhoneNumber,
          label: Strings.mobileNumber,
          fillColor: CustomColor.whiteColor,
          textInputType: TextInputType.number,
          phoneCode: controller.selectCountryCode.value,
          mobileCode: controller.selectCountryCode.value,
        ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.75));
  }

  _addressAndCityWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.addressController,
            hintText: Strings.address,
            label: Strings.address,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.sateController,
            hintText: Strings.state,
            label: Strings.state,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.75);
  }

  _stateAndZipCodeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.cityController,
            hintText: Strings.city,
            label: Strings.city,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.zipCodeController,
            hintText: Strings.zipCode,
            label: Strings.zipCode,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    ).paddingOnly(
      bottom: Dimensions.marginSizeVertical * 1.5,
    );
  }
}
