import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../routes/routes.dart';
import 'navigator_plug.dart';

class SplashController extends GetxController {
  final navigatorPlug = NavigatorPlug();
  @override
  void onReady() {
    super.onReady();

    navigatorPlug.startListening(
      seconds: 3,
      onChanged: () {
        Get.offAllNamed(
          LocalStorage.isLoggedIn()
              ? Routes.bottomNavBar
              : Routes.onboardScreen,
        );
      },
    );
    // _goToScreen();
  }
}
