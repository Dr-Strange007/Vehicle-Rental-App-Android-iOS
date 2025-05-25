import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_symbols_icons/symbols.dart';
import '/backend/local_storage/local_storage.dart';
import '/backend/services/api_endpoint.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/common/custom_container_widget.dart';
import '../../widgets/common/image_picker_widget.dart';
import '../web_view/web_view_screen.dart';
import '/controller/basic_settings/basic_settings_controller.dart';
import '/controller/profile/update_profile_controller.dart';
import '/language/language_drop_down.dart';
import '/widgets/app_logo/app_logo_widget.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final controller = Get.put(NavigationController());

  final basicSettingsController = Get.put(BasicSettingsController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      width: MediaQuery.sizeOf(context).width * 0.75,
      backgroundColor:
          Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.background.drawerBackground.path,
            ),
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: ListView(
          children: [
            _appLogoWidget(context),
            Visibility(
              visible: LocalStorage.isLoggedIn(),
              child: LocalStorage.isLoggedIn()
                  ? _userInfoWidget(context)
                  : Container(),
            ),
            _drawerTitle(context),
          ],
        ).paddingSymmetric(horizontal: Dimensions.marginSizeHorizontal * 0.5),
      ),
    );
  }

  _userInfoWidget(BuildContext context) {
    final profileController = Get.put(UpdateProfileController());
    return Obx(() => profileController.isLoading
        ? const CustomLoadingAPI()
        : Column(
            children: [
              Animate(
                effects: const [
                  FadeEffect(),
                  ScaleEffect(),
                ],
                child: ImagePickerWidget(
                  isPicker: false,
                  imageUrl: profileController
                      .profileInfoModel.data.userInfo.userImage,
                ),
              ),
              TitleHeading2Widget(
                text: profileController.profileInfoModel.data.userInfo.fullname,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
              )
                  .paddingOnly(
                    top: Dimensions.paddingSize * 0.5,
                    bottom: Dimensions.paddingSize * 0.1,
                  )
                  .animate()
                  .fadeIn(duration: 900.ms, delay: 300.ms)
                  .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
              TitleHeading4Widget(
                text: profileController.profileInfoModel.data.userInfo.email,
                color: CustomColor.secondaryLightTextColor,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              )
                  .paddingOnly(bottom: Dimensions.paddingSize * 0.8)
                  .animate()
                  .fadeIn(duration: 900.ms, delay: 300.ms)
                  .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
            ],
          ));
  }

  _appLogoWidget(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.close(1);
          },
          child: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode
                ? CustomColor.whiteColor
                : CustomColor.blackColor,
          ),
        ),
        horizontalSpace(Dimensions.widthSize * 3),
        LogoWidget(scale: 1.5),
      ],
    ).paddingOnly(
      bottom: Dimensions.paddingSize * 2.3,
      top: Dimensions.heightSize * 0.5,
    );
  }

  _drawerTitle(BuildContext context) {
    return Column(
        children: AnimateList(
      children: [
        buildMenuItem(
          context,
          title: Strings.services,
          imagePath: Symbols.settings,
          onTap: () {
            Get.to(
              () => WebViewScreen(
                title: Strings.services,
                url: "${ApiEndpoint.mainDomain}/services",
              ),
            );
          },
        ),
        buildMenuItem(
          context,
          title: Strings.blog,
          imagePath: Symbols.book_4,
          onTap: () {
            Get.to(
              () => WebViewScreen(
                title: Strings.blog,
                url: "${ApiEndpoint.mainDomain}/blog",
              ),
            );
          },
        ),
        buildMenuItem(
          context,
          title: Strings.contact,
          imagePath: Symbols.contact_page,
          onTap: () {
            Get.to(
              () => WebViewScreen(
                title: Strings.contact,
                url: basicSettingsController.contactUs.value,
              ),
            );
          },
        ),
        buildLanguageItem(
          context,
          title: Strings.language,
          imagePath: Symbols.g_translate,
          onTap: () {},
        ),
        Visibility(
          visible: LocalStorage.isLoggedIn(),
          child: buildMenuItem(
            context,
            title: Strings.changePassword,
            imagePath: Symbols.key,
            onTap: () {
              Get.toNamed(Routes.changePasswordScreen);
            },
          ),
        ),
        buildMenuItem(
          context,
          title: Strings.helpCenter,
          imagePath: Symbols.help,
          onTap: () {
            Get.to(
              () => WebViewScreen(
                title: Strings.helpCenter,
                url: basicSettingsController.contactUs.value,
              ),
            );
          },
        ),
        buildMenuItem(
          context,
          title: Strings.privacyPolicy,
          imagePath: Symbols.encrypted,
          onTap: () {
            Get.to(
              () => WebViewScreen(
                title: Strings.privacyPolicy,
                url: basicSettingsController.privacyPolicy.value,
              ),
            );
          },
        ),
        buildMenuItem(
          context,
          title: Strings.aboutUs,
          imagePath: Symbols.info,
          onTap: () {
            Get.to(
              () => WebViewScreen(
                title: Strings.aboutUs,
                url: basicSettingsController.aboutUs.value,
              ),
            );
          },
        ),
        Visibility(
          visible: LocalStorage.isLoggedIn(),
          child: buildMenuItem(
            context,
            title: Strings.signOut,
            imagePath: Symbols.power_settings_new,
            onTap: () {
              signOutDialog(context, controller);
            },
          ),
        ),
        Visibility(
          visible: !LocalStorage.isLoggedIn(),
          child: buildMenuItem(
            context,
            title: Strings.signIn,
            imagePath: Symbols.login,
            onTap: () {
              Get.toNamed(Routes.signInScreen);
            },
          ),
        ),
        verticalSpace(Dimensions.heightSize * 3),
      ],
    ));
  }

  buildMenuItem(
    context, {
    required String title,
    required IconData? imagePath,
    required VoidCallback onTap,
    double scaleImage = 1,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize,
            vertical: Dimensions.paddingSize * 0.1,
          ),
          child: ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Container(
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
              ),
              child: Icon(
                imagePath,
                size: Dimensions.heightSize * 1.5,
                color: CustomColor.whiteColor,
              ),
            ),
            title: TitleHeading3Widget(
              text: title,
            ),
            onTap: onTap,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 900.ms, delay: 300.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
        .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
  }

  buildLanguageItem(
    context, {
    required String title,
    required IconData? imagePath,
    required VoidCallback onTap,
    double scaleImage = 1,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize,
            vertical: Dimensions.paddingSize * 0.1,
          ),
          child: ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Container(
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
              ),
              child: Icon(
                imagePath,
                size: Dimensions.heightSize * 1.5,
                color: CustomColor.whiteColor,
              ),
            ),
            title: Row(
              children: [
                TitleHeading3Widget(
                  text: title,
                ),
                horizontalSpace(Dimensions.widthSize),
                SizedBox(
                  height: 28.h,
                  child: ChangeLanguageWidget(
                    isHome: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 900.ms, delay: 300.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
        .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
  }
}

signOutDialog(BuildContext context, NavigationController controller) {
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
                  text: Strings.signOut,
                  textAlign: TextAlign.start,
                ),
                verticalSpace(Dimensions.heightSize),
                const TitleHeading4Widget(
                  text: Strings.signOutMsg,
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
                          controller.signOutProcess();
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
