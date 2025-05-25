// ignore_for_file: unused_element, deprecated_member_use

import 'dart:ui';

import 'package:material_symbols_icons/symbols.dart';
import '/backend/local_storage/local_storage.dart';
import '/backend/utils/custom_snackbar.dart';
import '/views/drawer/drawer.dart';

import '../../controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/others/custom_image_widget.dart';
import '/widgets/app_logo/app_logo_widget.dart';

class NavigationMobileScreenLayout extends StatelessWidget {
  NavigationMobileScreenLayout({
    super.key,
    required this.navigationController,
  });

  final NavigationController navigationController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final Color primaryColor = Get.isDarkMode
      ? CustomColor.primaryDarkColor
      : CustomColor.primaryLightColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        key: _key,
        drawer: DrawerScreen(),
        appBar: _appBarWidget(context),
        bottomNavigationBar: buildBottomNavigationMenu(context),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Obx(() => LocalStorage.isLoggedIn()
        ? navigationController.page[navigationController.selectedIndex.value]
        : navigationController.page1[navigationController.selectedIndex.value]);
  }

  buildBottomNavigationMenu(context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.heightSize,
        left: Dimensions.widthSize,
        right: Dimensions.widthSize,
      ),
      child: Container(
        height: Dimensions.heightSize * 5.2,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: ShapeDecoration(
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 4),
              topRight: Radius.circular(Dimensions.radius * 4),
              bottomRight: Radius.circular(Dimensions.radius * 4),
              bottomLeft: Radius.circular(Dimensions.radius * 4),
            ),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x19000000), // fixed color
              blurRadius: Dimensions.radius,
              offset: const Offset(0, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: BottomAppBar(
          elevation: 0,
          notchMargin: 7,
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize * 2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  bottomItemWidget(
                      context, Symbols.account_circle, Strings.home, 0),
                  middleBottomItemWidget(
                      context, Symbols.home, "Strings.marketplace", 1),
                  bottomItemWidget(
                      context, Symbols.history, "Strings.myTrade", 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bottomItemWidget(context, var icon, label, page) {
    return Obx(
      () => InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          navigationController.selectedIndex.value = page;
        },
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.heightSize * 3,
          width: Dimensions.heightSize * 3.5,
          child: _buildRow(context, icon, label, page),
        ),
      ),
    );
  }

  middleBottomItemWidget(context, var icon, label, page) {
    return InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          navigationController.selectedIndex.value = page;
        },
        child: CircleAvatar(
          backgroundColor: CustomColor.whiteColor.withOpacity(0.10),
          radius: 55,
          child: _middleRow(context, icon, label, page),
        ));
  }

  _buildRow(context, var icon, label, page) {
    return Icon(
      icon,
      color: navigationController.selectedIndex.value == page
          ? CustomColor.whiteColor
          : CustomColor.whiteColor.withOpacity(0.5),
      size: navigationController.selectedIndex.value == page
          ? Dimensions.heightSize * 2
          : Dimensions.heightSize * 2,
    );
  }

  _middleRow(context, var icon, label, page) {
    return Icon(icon,
        // weight: 1,
        color: CustomColor.whiteColor,
        size: Dimensions.heightSize * 2.66);
  }

  _appBarWidget(context) {
    return navigationController.selectedIndex.value == 1
        ? _homeAppBarWidget(context)
        : _marketplaceAppBarWidget(context);
  }

  _homeAppBarWidget(context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          _key.currentState!.openDrawer(); // <-- Opens drawer
        },
        child: const Icon(Symbols.widgets),
      ),
      title: LogoWidget(scale: 1.5),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            LocalStorage.isLoggedIn()
                ? Get.toNamed(Routes.notificationScreen)
                : CustomSnackBar.error(Strings.signInMsg);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.5),
            child: const Icon(Symbols.notifications),
          ),
        ),
      ],
    );
  }

  _marketplaceAppBarWidget(context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: TitleHeading2Widget(
          text: _titleWidget(navigationController.selectedIndex.value)),
      centerTitle: true,
      actions: [
        _filterProcessWidget(context),
      ],
    );
  }

  _titleWidget(index) {
    switch (index) {
      case 0:
        return Strings.profile;
      case 1:
        return "Strings.myTrade";
      case 2:
        return Strings.historyList;
    }
  }

  _filterProcessWidget(BuildContext context) {
    return Visibility(
      visible: navigationController.selectedIndex.value == 1,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          _showFilterDialog(context);
        },
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.paddingSize * 0.3,
            horizontal: Dimensions.paddingSize * 0.25,
          ),
          decoration: ShapeDecoration(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            ),
          ),
          child: CustomImageWidget(
            path: "Assets.icon.menu",
            height: Dimensions.heightSize * 0.6,
          ),
        ),
      ),
    );
  }

  _showFilterDialog(BuildContext context) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6,
          sigmaY: 6,
        ),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.marginSizeHorizontal * 2.5,
            vertical: Dimensions.marginSizeVertical * 0.6,
          ),
          alignment: Alignment.topRight,
          surfaceTintColor: Theme.of(context).colorScheme.background,
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize),
            child: Column(
              mainAxisSize: mainMin,
              crossAxisAlignment: crossStart,
              children: [
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Get.back();
                            Get.close(1);
                          },
                          child:
                              const CustomImageWidget(path: "Assets.icon.back"),
                        ),
                        horizontalSpace(Dimensions.widthSize),
                        const TitleHeading4Widget(
                          text: "Strings.filters",
                          fontWeight: FontWeight.w500,
                          opacity: 0.30,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // marketplaceController.onResetFilterValue();
                      },
                      child: TitleHeading4Widget(
                        text: "Strings.reset",
                        fontSize: Dimensions.headingTextSize6,
                        opacity: 0.30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Get.isDarkMode
                      ? CustomColor.whiteColor.withOpacity(0.10)
                      : CustomColor.blackColor.withOpacity(0.10),
                ),
                // CurrencyDropDown(isDialogField: true),
                verticalSpace(Dimensions.heightSize * 0.5),
                const TitleHeading4Widget(
                  text: "Strings.selectAmount",
                  fontWeight: FontWeight.w500,
                  opacity: 0.30,
                ),
                Obx(
                  () => SizedBox(
                    height: Dimensions.heightSize * 1.7,
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: Dimensions.radius * 0.8),
                        trackShape: CustomTrackShape(),
                      ),
                      child: Slider(
                        value: 0.4,
                        // value: marketplaceController.amount.value,
                        onChanged: (newValue) {
                          // marketplaceController.amount.value = newValue;
                        },
                        min: 0,
                        max: 100,
                        thumbColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => TitleHeading4Widget(
                    text:
                        "marketplaceController.amount.value.toStringAsFixed(2)",
                    fontSize: Dimensions.headingTextSize6,
                    opacity: 0.30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(Dimensions.heightSize),
                const TitleHeading4Widget(
                  text: "Strings.selectRate",
                  fontWeight: FontWeight.w500,
                  opacity: 0.30,
                ),
                Obx(
                  () => SizedBox(
                    height: Dimensions.heightSize * 1.7,
                    width: double.infinity,
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: Dimensions.radius * 0.8),
                        trackShape: CustomTrackShape(),
                      ),
                      child: Slider(
                        value: 0.33,
                        onChanged: (newValue) {
                          // marketplaceController.rate.value = newValue;
                        },
                        min: 0,
                        max: 100,
                        thumbColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => TitleHeading4Widget(
                    text: "marketplaceController.rate.value.toStringAsFixed(2)",
                    fontSize: Dimensions.headingTextSize6,
                    opacity: 0.30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(Dimensions.heightSize * 1.4),
                PrimaryButton(
                  height: Dimensions.buttonHeight * 0.6,
                  title: "Strings.search",
                  onPressed: () {
                    Get.close(1);
                  },
                  borderColor: CustomColor.primaryLightColor,
                  buttonColor: CustomColor.primaryLightColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx + 5;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
