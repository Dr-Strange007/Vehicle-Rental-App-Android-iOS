import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/views/bottom_nav_bar/dashboard/dashboard.dart';
import '/views/bottom_nav_bar/history/history.dart';
import '/views/bottom_nav_bar/profile/profile_screen.dart';
import '/views/sign_in_now/sign_in_now_screen.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/common/common_success_model.dart';
import '../../backend/services/auth/auth_api_services.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

final navigationController = Get.put(NavigationController());

class NavigationController extends GetxController {
  final RxInt selectedIndex = 1.obs;

  final List page = [
    Visibility(
      visible: LocalStorage.isLoggedIn(),
      child: const ProfileScreen(),
    ),
    const DashboardScreen(),
    Visibility(
      visible: LocalStorage.isLoggedIn(),
      child: const HistoryScreen(),
    ),
  ];

  final List page1 = [
    Visibility(
      visible: !LocalStorage.isLoggedIn(),
      child: const SignInNowScreen(),
    ),
    const DashboardScreen(),
    Visibility(
      visible: !LocalStorage.isLoggedIn(),
      child: const SignInNowScreen(),
    ),
  ];

  void selectedPage(int index) {
    selectedIndex.value = index;
  }

  /// >> set loading process & model
  final _isLoading = false.obs;
  late CommonSuccessModel _signOutModel;

  /// >> get loading process & model
  bool get isLoading => _isLoading.value;
  CommonSuccessModel get signOutModel => _signOutModel;

  ///* Sign out process
  Future<CommonSuccessModel> signOutProcess() async {
    _isLoading.value = true;
    update();

    await AuthApiServices.signOutProcessApi(body: {}).then((value) {
      _signOutModel = value!;
      _whenSignOutCompleted();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _signOutModel;
  }

  void _whenSignOutCompleted() {
    LocalStorage.signOut();
    Get.offNamedUntil(Routes.signInScreen, (route) => false);
  }
}
