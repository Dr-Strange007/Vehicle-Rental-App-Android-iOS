import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../backend/model/basic_settings/basic_settings_info_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/basic_settings/basic_settings_api_services.dart';
import '../../backend/utils/api_method.dart';
import '/backend/local_storage/local_storage.dart';

class BasicSettingsController extends GetxController {
  RxString splashImage = ''.obs;
  RxString onboardImage = ''.obs;
  RxString onBoardTitle = ''.obs;
  RxString onBoardSubTitle = ''.obs;
  RxString appBasicLogo = ''.obs;
  RxString privacyPolicy = ''.obs;
  RxString contactUs = ''.obs;
  RxString aboutUs = ''.obs;

  RxBool isVisible = false.obs;
  @override
  void onInit() {
    getBasicSettingsApiProcess().then(
      (value) => Timer(const Duration(seconds: 4), () {
        isVisible.value = true;
      }),
    );
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  late BasicSettingsInfoModel _appSettingsModel;
  BasicSettingsInfoModel get appSettingsModel => _appSettingsModel;

  Future<BasicSettingsInfoModel> getBasicSettingsApiProcess() async {
    _isLoading.value = true;
    update();
    await BasicSettingsApiServices.getBasicSettingProcessApi().then((value) {
      _appSettingsModel = value!;
      saveInfo();
      update();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });
    _isLoading.value = false;
    update();
    return _appSettingsModel;
  }

  void saveInfo() {
    /// >>> get splash & onboard data
    var onBoardData = _appSettingsModel.data.onboardScreens.first;
    var imageSplash = _appSettingsModel.data.splashScreen.first.image;
    var imageOnboard = onBoardData.image;
    var imagePath = _appSettingsModel.data.appImagePaths.pathLocation;
    splashImage.value = "${ApiEndpoint.mainDomain}/$imagePath/$imageSplash";
    onboardImage.value = "${ApiEndpoint.mainDomain}/$imagePath/$imageOnboard";
    onBoardTitle.value = onBoardData.title;
    onBoardSubTitle.value = onBoardData.subTitle;
    LocalStorage.saveCurrencyCode(
        code: _appSettingsModel.data.basicSettings.currencyCode);
    appBasicLogo.value =
        "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.imageAssets.pathLocation}/${_appSettingsModel.data.allLogo.siteLogo}";
    LocalStorage.saveImage(
        image:
            "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.imageAssets.pathLocation}/${_appSettingsModel.data.allLogo.siteLogo}");
    debugPrint("📁📁📁📁📁📁${appBasicLogo.value}");
    privacyPolicy.value = _appSettingsModel.data.webLinks.privacyPolicy;
    contactUs.value = _appSettingsModel.data.webLinks.contactUs;
    aboutUs.value = _appSettingsModel.data.webLinks.aboutUs;
  }
}
