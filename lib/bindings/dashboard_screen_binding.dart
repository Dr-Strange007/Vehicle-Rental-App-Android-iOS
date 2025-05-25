import 'package:get/get.dart';

import '/controller/profile/update_profile_controller.dart';


class DashboardScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateProfileController());
  }
}
