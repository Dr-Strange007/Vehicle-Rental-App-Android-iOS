import '/backend/utils/custom_loading_api.dart';
import '/controller/change_password/change_password_controller.dart';

import '../../utils/basic_screen_imports.dart';
import '../../widgets/inputs/primary_input_widget.dart';

class ChangePasswordMobile extends StatelessWidget {
  ChangePasswordMobile({super.key});

  final formKey = GlobalKey<FormState>();
  final Color buttonColor = Get.isDarkMode
      ? CustomColor.primaryDarkColor
      : CustomColor.primaryLightColor;
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.changePassword),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: ListView(
        // crossAxisAlignment: crossCenter,
        children: [
          _inputFieldWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 1.66,
      ),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.changePassword,
              onPressed: () {
                controller.changePasswordProcess();
                // controller.onResetPassword;
              },
              borderColor: buttonColor,
              buttonColor: buttonColor,
            )),
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PrimaryInputWidget(
            controller: controller.oldPasswordController,
            hintText: Strings.enterOldPassword,
            label: Strings.oldPassword,
            // prefixIconPath: Assets.icon.lock,
            fillColor: CustomColor.primaryBGLightColor,
            isPasswordField: true,
            textInputType: TextInputType.text,
          ),
          verticalSpace(Dimensions.heightSize * 1.33),
          PrimaryInputWidget(
            controller: controller.newPasswordController,
            hintText: Strings.enterNewPassword,
            label: Strings.newPassword,
            // prefixIconPath: Assets.icon.lock,
            fillColor: CustomColor.primaryBGLightColor,
            isPasswordField: true,
            textInputType: TextInputType.text,
          ),
          verticalSpace(Dimensions.heightSize * 1.33),
          PrimaryInputWidget(
            controller: controller.confirmPasswordController,
            hintText: Strings.enterConfirmPassword,
            label: Strings.confirmPassword,
            // prefixIconPath: Assets.icon.lock,
            fillColor: CustomColor.primaryBGLightColor,
            isPasswordField: true,
            textInputType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
